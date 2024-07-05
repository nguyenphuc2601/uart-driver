libs_source = []
libs_inc = []
list_libs_files = run_command('find','.','-name','*.c','-or','-name','*.cpp',check : true)

if list_libs_files.stdout().contains('/')
	libs_source += files(list_libs_files.stdout().strip().replace('./','').split('\n'))

	libs_inc += include_directories('inc')
endif