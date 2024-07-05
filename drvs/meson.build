drvs_source = []
drvs_inc = []

list_drvs_files = run_command('find','.','-name','*.c','-or','-name','*.cpp',check : true)

#Check if folder is empty
if list_drvs_files.stdout().contains('/')

  drvs_source += files(list_drvs_files.stdout().strip().replace('./','').split('\n'))

  drvs_inc += include_directories('inc')

endif