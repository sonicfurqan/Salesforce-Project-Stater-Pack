@IsTest
global class TestDataFactory {

    private static Id systemAdministratorProfileId = null;
	private static Id standardUserProfileId = null;
    public static Integer randomInteger(final Integer maxValue) {
        return Integer.valueOf(Math.random() * maxValue);
    }

    public static String randomString(final Integer length) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
        String result = '';
        while (result.length() < length) {
            Integer i = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            result += chars.substring(i, i + 1);
        }
        return result;
    }

    /**
	 * Creates a ContentVersion File
	 * Example:
	 * <pre>
	 * static testMethod void myTest() {
	 *   ContentVersion cv=TestDataFactory.createContentVersion(true);
	 * }
	 * </pre>
	 * @return ContentVersion
	 */
    public static ContentVersion createContentVersion(Boolean isInsert) {
		String id = randomString(8);
		ContentVersion cv = new ContentVersion(
			Title = id,
			PathOnClient = id + '.pdf',
			VersionData = Blob.valueOf(randomString(40)),
			IsMajorVersion = false);
        if(isInsert){
            insert cv;
            return [
                SELECT ContentDocumentId, Title, PathOnClient, FileExtension, VersionData, ContentSize, LastModifiedDate
                FROM ContentVersion
                WHERE Id = :cv.Id
                LIMIT 1
            ];
        }
        return cv;
	}



    /**
	 * Creates a System Admin user
	 * Example:
	 * <pre>
	 * static testMethod void myTest() {
	 *   System.runAs(TestDataFactory.getAdminUser()) {
	 *     // Code
	 *   }
	 * }
	 * </pre>
	 * @return A Admin user
	 */
    public static User getAdminUser() {
		return createUser(getSystemAdministratorProfileId(), randomString(10) + '@unit.test');
	}
    /**
	 * Creates a Standard user
	 * Example:
	 * <pre>
	 * static testMethod void myTest() {
	 *   System.runAs(TestDataFactory.getStandardUser()) {
	 *     // Code
	 *   }
	 * }
	 * </pre>
	 * @return A Standard user
	 */
    public static User getStandardUser() {
		return createUser(getStandardUserProfileId(), randomString(7) + '@unit.test');
	}

    private static User createUser(final Id profileId, final String email) {
        User u = new User(
			Email = email,
			Phone = '5555555555',
			FirstName = 'UNIT',
			LastName = 'TEST',
			Username = email,
			Alias = 'test',
			TimeZoneSidKey = 'America/Los_Angeles',
			LocaleSidKey = 'en_US',
			EmailEncodingKey = 'ISO-8859-1',
			ProfileId = profileId,
			LanguageLocaleKey = 'en_US'
			);
		insert u;


		return [
			SELECT Id, FirstName, LastName, Name, Email, Profile.Name, Phone, MobilePhone
			FROM User
			WHERE Id = :u.Id
			LIMIT 1
		];
	}
    private static Id getStandardUserProfileId() {
		if (standardUserProfileId == null) {
			standardUserProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard User' LIMIT 1].Id;
		}
		return standardUserProfileId;
	}
    private static Id getSystemAdministratorProfileId() {
		if (systemAdministratorProfileId == null) {
			systemAdministratorProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1].Id;
		}
		return systemAdministratorProfileId;
	}
   
}
