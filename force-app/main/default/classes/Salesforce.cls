public with sharing class Salesforce {

	private static final Map<String, SObjectType> GLOBAL_DESCRIBE;
	
	private static final Url BASE_URL;
	@TestVisible
	private static final String INSTANCE_NAME;
	private static final String NAMESPACE_PREFIX;
    private static  String VISUALFORCE_URL;
    private static  String LIGHTNING_URL;
	private static final Boolean IS_SANDBOX;
	private static final String ORG_TYPE;
	public static final Double API_VERSION = 46.0;

	@AuraEnabled
	public static String visualforceOrigins{
		get {
            if(VISUALFORCE_URL!=null){
                return VISUALFORCE_URL;
            }
            else{
                String host = BASE_URL.getHost();
			    String myDomain = host.substringBefore('.');
                String url=getOrigin(
					myDomain,
					null,
					null,
					'visualforce.com');
                    VISUALFORCE_URL=url;
                    return VISUALFORCE_URL;
            }
			
		}
	}
	@AuraEnabled
	public static String lightningOrigins{
		get {
            if(LIGHTNING_URL!=null){
                return LIGHTNING_URL;
            }else{
                String host = BASE_URL.getHost();
			    String myDomain = host.substringBefore('.');
                String url=getOrigin(
					myDomain,
					null,
					null,
					'lightning.force.com');
                    LIGHTNING_URL=url;
                    return LIGHTNING_URL;
            }
			
		}
	}
    @AuraEnabled
	public static Url baseUrl {
		get {
			return BASE_URL;
		}
	}
     @AuraEnabled
	public static Boolean isSandbox {
		get {
			return IS_SANDBOX;
		}
	}
     @AuraEnabled
	public static String namespace {
		get {
			return NAMESPACE_PREFIX;
		}
	}
     @AuraEnabled
	public static String edition {
		get {
			return ORG_TYPE;
		}
	}

	static {
		String siteBaseUrl = Site.getBaseUrl();
		BASE_URL = String.isNotBlank(siteBaseUrl) ? new Url(siteBaseUrl) : Url.getOrgDomainUrl();
		Organization org = [SELECT InstanceName, IsSandbox, OrganizationType, NamespacePrefix FROM Organization LIMIT 1];
		INSTANCE_NAME = org.InstanceName.toLowerCase();
		IS_SANDBOX = org.IsSandbox;
		ORG_TYPE = org.OrganizationType;
		NAMESPACE_PREFIX = org.NamespacePrefix;
		GLOBAL_DESCRIBE = Schema.getGlobalDescribe();
        
	}

	@TestVisible
	private static String getOrigin(
		final String myDomain,
		final String namespace,
		final String instance,
		final String rootDomain) {

		String result = null;

		// Add instance name to origin if critical update is disabled
		if (String.isNotBlank(instance)) {
			if (String.isNotBlank(namespace)) {
				result = String.format('https://{0}--{1}.{2}.{3}', new List<String> {
					myDomain,
					namespace,
					INSTANCE_NAME,
					rootDomain
				});
			} else {
				result = String.format('https://{0}.{1}.{2}', new List<String> {
					myDomain,
					INSTANCE_NAME,
					rootDomain
				});
			}
		} else if (String.isNotBlank(namespace)) {
			result = String.format('https://{0}--{1}.{2}', new List<String> {
				myDomain,
				namespace,
				rootDomain
			});
		} else {
			result = String.format('https://{0}.{1}', new List<String> {
				myDomain,
				rootDomain
			});
		}

		return result;
	}


}
