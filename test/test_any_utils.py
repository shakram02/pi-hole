def test_key_val_replacement_works(host):
    ''' Confirms addOrEditKeyValPair provides the expected output '''
    host.run('''    
    source /opt/pihole/utils.sh
    addOrEditKeyValPair "KEY_ONE" "value1" "./testoutput"
    addOrEditKeyValPair "KEY_TWO" "value2" "./testoutput"
    addOrEditKeyValPair "KEY_ONE" "value3" "./testoutput"
    addOrEditKeyValPair "KEY_FOUR" "value4" "./testoutput"
    addOrEditKeyValPair "KEY_FIVE_NO_VALUE" "./testoutput"
    addOrEditKeyValPair "KEY_FIVE_NO_VALUE" "./testoutput"
    ''')
    output = host.run('''
    cat ./testoutput
    ''')
    expected_stdout = 'KEY_ONE=value3\nKEY_TWO=value2\nKEY_FOUR=value4\nKEY_FIVE_NO_VALUE\n'
    assert expected_stdout == output.stdout


def test_key_val_removal_works(host):
    ''' Confirms addOrEditKeyValPair provides the expected output '''
    host.run('''
    source /opt/pihole/utils.sh
    addOrEditKeyValPair "KEY_ONE" "value1" "./testoutput"
    addOrEditKeyValPair "KEY_TWO" "value2" "./testoutput"
    addOrEditKeyValPair "KEY_THREE" "value3" "./testoutput"
    removeKey "KEY_TWO" "./testoutput"
    ''')
    output = host.run('''
    cat ./testoutput
    ''')
    expected_stdout = 'KEY_ONE=value1\nKEY_THREE=value3\n'
    assert expected_stdout == output.stdout