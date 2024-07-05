project('HELLOWORLD_ARM', 'c',
  version : '0.1',
  default_options : [
    'b_lundef=false',
    'b_asneeded=false',
    'b_pch=false',
    'b_colorout=auto',
    'warning_level=3',
    'c_std=gnu11',
    'cpp_std=c++11',
    'cpp_std=c++14',
    'buildtype=plain',
    'debug=true'])
# This is middleware include include



r = run_command('pwd', check: true)

project_path = r.stdout().strip()

project_name = project_path.split('/')[-1]

build_path = project_path + '/build/'
bsp_path = project_path + '/bsp/'
app_path = project_path + '/app/'
libs_path = project_path + '/libs/'
drvs_path = project_path + '/drvs/'
tests_path = project_path + '/tests/'
utils_path = project_path + '/utils/'

mcu_chip   = meson.get_external_property('cpu_name')
mcu_core   = host_machine.cpu()
mcu_family = meson.get_external_property('cpu_series')

elf_file = project_name + '.elf'
bin_file = project_name + '.bin'




freertos_enable = get_option('freertos').enabled()
libjpeg_enable = get_option('libjpeg').enabled()
fatfs_enable = get_option('fatfs').enabled()
mbedtls_enable = get_option('mbedtls').enabled()

mcpu_args = '-mcpu=' + host_machine.cpu()

# Add your path
subdir('bsp')
subdir('drvs')
subdir('utils')
subdir('libs')
subdir('app')
subdir('tests')

uproj = subproject('unity')

message('\nTarget microcontoller:',mcu_chip,'\nMicrocontroller core:' + mcu_core,'\nMicrocontroller family:' + mcu_family)

source_files = [core_source ,
                drivers_source,
                middleware_source,
                startup_deb,
                app_source, 
                drvs_source,
                libs_source,
                utils_source]




# Build final binary
exe =  executable(project_name,
                  source_files,
                  name_suffix : 'elf',
                  include_directories : [bsp_inc,
                                         app_inc,
                                         drvs_inc,
                                         libs_inc,
                                         utils_inc], # Add ur include path
                  link_depends : [linker_path],
                  c_args : [
                            mcpu_args,
                            meson.get_cross_property('c_arg'),
                            meson.get_cross_property('c_macro'),
                            get_option('debug_opt'),
                            '-fdiagnostics-color=always'],
                  link_args : [
                            mcpu_args,
                            extra_linker_args,
                            meson.get_cross_property('c_link_arg'),
                            '-fdiagnostics-color=always']
                            ) # Add ur dependency

#==============================================================================#
# import binary objects
objcopy  = '@0@'.format(find_program('objcopy').path())
objdump  = '@0@'.format(find_program('objdump').path())
size     = '@0@'.format(find_program('size').path())
gdb      = '@0@'.format(find_program('gdb').path())
terminal = '@0@'.format(find_program('terminal',required:false).path())
openocd  = '@0@'.format(find_program('openocd', required:false).path())

#==============================================================================#
# create custom target : create binary, hex dump, size and disassemble dump
mainbin = custom_target(
                        bin_file,
    output           : [bin_file,],
    # name_suffix      : 'bin',
    build_by_default : true,
    command          : [objcopy, '-O', 'binary', elf_file, bin_file],
    depends          : [exe])


mainsize = custom_target(
                          'size',
        capture          : true,
        output           : [project_name + '.size'],
        build_by_default : true,
        command          : [size, elf_file],
        depends          : [exe])



maindump = custom_target(
                        'list',
      capture          : true,
      output           : [project_name + '.list'],
      build_by_default : true,
      command          : [objdump,'-h','-D', '-S', '-t', elf_file],
      depends          : [exe])



meson.add_install_script(project_path + '/tools/sup_flash.sh',[build_path + elf_file,'stm32' + mcu_family.to_lower()+'x.cfg'])

