# mcu_family variable contains type of mcu eg:F4,F1,G0,..
# mcu_series variable contains series of mcu f411

#

# Here your source code include path

# Core directory
core_inc = include_directories('Core/Inc')
core_src = include_directories('Core/Src')
core_startup = include_directories('Core/Startup')
core_dep = [core_inc,core_src,core_startup]
# Driver directory
## CMSIS directory
cmsis_inc = include_directories('Drivers/CMSIS/Include')
device_inc = include_directories('Drivers/CMSIS/Device/ST/STM32' + mcu_family + 'xx/Include')
cmsis_dep = [cmsis_inc,device_inc]
## STM32F HAL Drivers
hal_inc = include_directories('Drivers/STM32' + mcu_family + 'xx_HAL_Driver/Inc')
hal_legacy_inc = include_directories('Drivers/STM32' + mcu_family + 'xx_HAL_Driver/Inc/Legacy')
hal_src = include_directories('Drivers/STM32' + mcu_family + 'xx_HAL_Driver/Src')
hal_dep = [hal_inc,hal_legacy_inc,hal_src]


bsp_inc = [core_dep, cmsis_dep, hal_dep]


# Include path for generated middleware
if freertos_enable == true
  freertos_dep = []
  freertos_dep += include_directories('Middlewares/Third_Party/FreeRTOS/Source/include')
  freertos_dep += include_directories('Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2')
  freertos_dep += include_directories('Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F')
  freertos_dep += include_directories('Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang')
  bsp_inc += freertos_dep
endif

if fatfs_enable == true
  fatfs_dep = []
  fatfs_dep += include_directories('FATFS/Target')
  fatfs_dep += include_directories('FATFS/App')
  fatfs_dep += include_directories('Middlewares/Third_Party/FatFs/src')
  bsp_inc += fatfs_dep
endif

if libjpeg_enable == true
  libjpeg_Dep = []
  libjpeg_dep = include_directories('LIBJPEG/Target')
  libjpeg_dep += include_directories('LIBJPEG/App')
  libjpeg_dep += include_directories('Middlewares/Third_Party/LibJPEG/include')
  bsp_inc += libjpeg_dep
endif

if mbedtls_enable == true
  mbedtls_dep = []
  mbedtls_dep += include_directories('MBEDTLS/App')
  mbedtls_dep += include_directories('Middlewares/Third_Party/mbedTLS/include/mbedtls')
  mbedtls_dep += include_directories('Middlewares/Third_Party/mbedTLS/include')
  bsp_inc += mbedtls_dep
endif




# Core_source file
list_core_file = run_command('find','./Core','-name','*.c','-or','-name','*.cpp',check : false)

core_source = files(list_core_file.stdout().strip().replace('./','').split('\n'))

# Drivers source file
list_drivers_file = run_command('find','./Drivers/STM32' + mcu_family + 'xx_HAL_Driver/','-name','*.c','-or','-name','*.cpp',check : false)

drivers_source = files(list_drivers_file.stdout().strip().replace('./','').split('\n'))

#Middileware source file
middleware_source = []

if freertos_enable == true
  middleware_source += files('Middlewares/Third_Party/FreeRTOS/Source/croutine.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/event_groups.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/list.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/queue.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/stream_buffer.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/tasks.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/timers.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/heap_4.c',
                      'Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS_V2/cmsis_os2.c'
                      )
endif

if fatfs_enable == true
  middleware_source += files('Middlewares/Third_Party/FatFs/src/diskio.c',
                      'Middlewares/Third_Party/FatFs/src/ff_gen_drv.c',
                      'Middlewares/Third_Party/FatFs/src/ff.c',
                      'FATFS/App/fatfs.c',
                      'FATFS/Target/user_diskio.c'
                      )
endif

linker_script = mcu_chip.to_upper() + '_FLASH.ld'
linker_path = bsp_path + linker_script

map_path = build_path + project_name + '.map'

extra_linker_args = [
              '-T' + linker_path,
              '-Wl,--cref',
              '-Wl,-Map=' + map_path
              ]

  
##############################################################
# BUILD STARTUP FILE SEPARATE
asm_source = files('Core/Startup/startup_' + mcu_chip.to_lower() + '.s')
startup_inc = include_directories('Core/Startup')

cc = '@0@'.format(find_program('c').path())
startup_deb = custom_target(
                          'startup_' + mcu_chip.to_lower(),
                          output : ['startup_' + mcu_chip.to_lower() + '.o'],
                          input : [asm_source],
                          command : [cc,
                          mcpu_args,
                          get_option('debug_opt'),
                          '-c',
                          meson.get_external_property('asm_args'),
                          '-o',
                          '@OUTPUT0@',
                          '@INPUT0@'])










