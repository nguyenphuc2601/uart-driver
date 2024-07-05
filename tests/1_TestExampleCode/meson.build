test_dir = include_directories('.')

example_test = executable('Example_Test_Program', ['TestExampleCode_Runner.c','TestExampleCode.c','ProductionCode.c'],
                         include_directories : [unity_inc, test_dir],
                         dependencies : unity_dep, 
                         native: true)

test('Example_Test_Program',example_test)