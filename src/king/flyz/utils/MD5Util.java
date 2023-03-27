package king.flyz.utils;

import java.security.MessageDigest;

/**
 * MD5º”√‹¿‡
 * @√Ë ˆ£∫√‹¬Îº”√‹
 *
 */
public final class MD5Util {

	/**
	 * Md5º”√‹
	 * @param s
	 * @return
	 */
	public final static String md5(String s) {
        char hexDigits[] = { '0', '1', '2', '3', '4',
                             '5', '6', '7', '8', '9',
                             'A', 'B', 'C', 'D', 'E', 'F'};
        try {
            byte[] btInput = s.getBytes();
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            mdInst.update(btInput);
            byte[] md = mdInst.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
	
	public static void main(String[] args) {
		System.out.println(MD5Util.md5("admin"));
	}
}
