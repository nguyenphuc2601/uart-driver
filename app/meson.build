app_source = []
app_inc = []

list_app_files = run_command('find','.','-name','*.c','-or','-name','*.cpp',check : true)

if list_app_files.stdout().contains('/')
	app_source += files(list_app_files.stdout().strip().replace('./','').split('\n'))

	app_inc += include_directories('inc')
endif