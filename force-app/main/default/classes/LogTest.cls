@IsTest(isParallel = true)
private class LogTest {


	@IsTest
	static void test_exception() {
        Test.startTest();
        try{
            Integer i=1/0;
        }catch(Exception e){
            Log.exception(e);
            Log.exception(e, 'Exception');
            System.assertNotEquals(null,  e);
        }
		
		Test.stopTest();

		
	}

	

	@IsTest
	static void test_error() {
		Test.startTest();
	    Log.error('ERROR1');
		Test.stopTest();
    }

	@IsTest
	static void test_warning() {
		Test.startTest();
		Log.warn('WARNING1');
		Test.stopTest();
    }

	@IsTest
	static void test_info() {
        Test.startTest();
		Log.info('INFO1');
		Test.stopTest();
	}

	@IsTest
	static void test_debug() {
		Test.startTest();
		Log.debug('DEBUG1');
		Test.stopTest();
	}

	
}