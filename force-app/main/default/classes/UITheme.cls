public class UITheme {
    public enum Theme {
		Classic, Lightning, Salesforce1, Other
	}

	public static Theme getTheme() {
		return	setTheme(UserInfo.getUiThemeDisplayed());
	}

	@TestVisible
	private static Theme setTheme(final String t) {
        Theme currentThemeInternal;
		if (t == 'Theme1' || t == 'Theme2' || t == 'Theme3') {
			currentThemeInternal = Theme.Classic;
		} else if (t == 'Theme4d') {
			currentThemeInternal = Theme.Lightning;
		} else if (t == 'Theme4t') {
			currentThemeInternal = Theme.Salesforce1;
		} else {
			currentThemeInternal = Theme.Other;
		}
        return currentThemeInternal;
	}

	
}
