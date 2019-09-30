@IsTest(isParallel = true)
private class UIThemeTest {

	

	@IsTest
	static void test_Classic_Theme1() {
		UITheme.setTheme('Theme1');

		Test.startTest();
		System.assertEquals(UITheme.Theme.Classic, UITheme.getTheme());
		Test.stopTest();
	}

	@IsTest
	static void test_Classic_Theme2() {
		UITheme.setTheme('Theme2');

		Test.startTest();
		System.assertEquals(UITheme.Theme.Classic, UITheme.getTheme());
		Test.stopTest();
	}

	@IsTest
	static void test_Classic_Theme3() {
		UITheme.setTheme('Theme3');

		Test.startTest();
		System.assertEquals(UITheme.Theme.Classic, UITheme.getTheme());
		Test.stopTest();
	}

	@IsTest
	static void test_Salesforce1() {
		UITheme.setTheme('Theme4t');

		Test.startTest();
		System.assertEquals(UITheme.Theme.Salesforce1, UITheme.getTheme());
		Test.stopTest();
	}

	@IsTest
	static void test_Lightning() {
		UITheme.setTheme('Theme4d');

		Test.startTest();
		System.assertEquals(UITheme.Theme.Lightning, UITheme.getTheme());
		Test.stopTest();
	}

	@IsTest
	static void test_other() {
		UITheme.setTheme('PortalDefault');

		Test.startTest();
		System.assertEquals(UITheme.Theme.Other, UITheme.getTheme());
		Test.stopTest();
	}
}