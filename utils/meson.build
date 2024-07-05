utils_source = []
utils_inc = []

list_utils_files = run_command('find','.','-name','*.c','-or','-name','*.cpp',check : true)

if list_utils_files.stdout().contains('/')
	utils_source += files(list_utils_files.stdout().strip().replace('./','').split('\n'))

	utils_inc += include_directories('inc')
endif