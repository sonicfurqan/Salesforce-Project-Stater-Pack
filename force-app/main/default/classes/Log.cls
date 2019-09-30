public  class Log {
    
	
	/**
	 * This method builds and logs a message at error logging level using the provided Exception.
	 * @param ex Exception object to log
	 */
	public static void exception(final Exception ex) {
		Log.exception(ex, '');
	}

	/**
	 * This method builds and logs a message at error logging level using the provided exception and additional context.
	 *
	 * @param ex The exception to log.
	 * @param context Additional context to log.
	 */
	public static void exception(final Exception ex, final String msg) {
		String fullMessage = '';
		if (String.isNotBlank(msg)) {
			fullMessage += msg + '\n';
		}
		if (ex != null) {
			fullMessage += String.format('{0}: {1}\n{2}', new List<String> {
				ex.getTypeName(),
				ex.getMessage(),
				ex.getStackTraceString()
			});
		}
		if (String.isNotBlank(fullMessage)) {
			Log.error(fullMessage);
		}
	}

	/**
	 * This method builds and logs a message at error logging level using the provided message.
	 * @param message String to log
	 */
	public static void error(final String message) {
		Log.log(System.LoggingLevel.ERROR, message);
	}

	/**
	 * This method builds and logs a message at warning logging level using the provided message.
	 * @param message String to log
	 */
	public static void warn(final String message) {
		Log.log(System.LoggingLevel.WARN, message);
	}

	/**
	 * This method builds and logs a message at info logging level using the provided message.
	 * @param message String to log
	 */
	public static void info(final String message) {
		Log.log(System.LoggingLevel.INFO, message);
	}

	/**
	 * This method builds and logs a message at debug logging level using the provided message.
	 * @param message String to log
	 */
	public static void debug(final String message) {
		Log.log(System.LoggingLevel.DEBUG, message);
	}

	
	private static void log(final System.LoggingLevel level, final String message) {
		if (String.isNotBlank(message)) {
			System.debug(level, message);
		}
	}
}