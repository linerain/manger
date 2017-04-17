package com.zyytkj.system.cache;

import java.util.ArrayList;
import java.util.List;

public class LicenceCache {

	private static List<String> licenceCache = new ArrayList<String>();

	public static List<String> getLicenceCache() {
		return licenceCache;
	}

	public static void setLicenceCache(List<String> licenceCache) {
		LicenceCache.licenceCache = licenceCache;
	}

}
