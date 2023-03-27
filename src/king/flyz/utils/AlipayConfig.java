package king.flyz.utils;

public class AlipayConfig {

    // 应用ID
    public static String app_id = "2021000119683613";

    // 商户私钥 
    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCSiwhH/Mp7udjwsZ7DGtZJqcEt7KkZzx2sviv3qEbm1bqd81zC0yuFL0mHPrtFUCvD9jz4sTaNhjZDNOrg91dT5Tu0/xUjWzTKF/TkOLysx+eTSZ/hkjKmFCrL9I9sd6Hzb7YAF1hfbc6n3eMTXHcXnrOZFvo7gmCQgsd0q8WHHPmAo1vI6zEqw8mewshezd7v0KIwHAWNB2lUnD0qrDWoUBSrkbF1GtdTBq1tHAXmIshFpZBpg02LqeukggVfYIM47ggENF7w+dJ272AxSMwJ74NqxHJQ2Ac6sHbSuk+7BvKMsaedFbII4/haChPJBzmAEwq3Fx1YC2w6jM//fbbJAgMBAAECggEAQZXN8AH4UWV87URhbKqPK0q5NaeMiwuCGXTHUsDScq9HJTfs1RkTijj+rHPr9nqKC9shsKAHbVGa6Xs+f87TG64libz8JeXE+4m7RYULFD0nrGiwEJGQ73lpKfzbT80/AyeFCgdoutT3P3P0FA83EbAqayK4fXe9Zg/R2qqh7fThalosa9wcVMM3bvUQT8Au5LkkFqtm5uU1drSr0GFLutCSNN4Z3l6H0xU53QZbNQp1HmNdE20tOItitZOEdhpeQtc7+7PSkngDuI3+1WgcMGPd/tHnVbJrz/b4240cCVn7DAYKjTyAgnIbK0dGFEdmf0KWMCuzc95UN+qmQFHecQKBgQDB4s3DFcFDWXJR8NtI/P7kgsQueBZJORMKYEKI+f3ENrGvhnWiNLVDaemBW4cVjAhO9jdvRstXtEQXQenKv/tWgy2Eysyla63JkGkWPHT1mWI8WLgyBbiRyEbzRCnejOfkll24sc3lEyZiJuNdiLupB8iIhkjWxYTsMajBu4Eg1QKBgQDBfX36eGKQJnRr2fVvDbyFjPL1kz9Iav7VJj0AdGaX8122QkReHQTTmhlm8gLFA570TCKyw3oQjSk/IOWytsvfmvPr/sxvLpsQmjE2yUaCW9lATx5KXndYT0H+xhVG0b6N/iN88CiwCTCZN2FjDSUlUdFDs1Ve1MXG8oNz/8AYJQKBgF1I7o8qbG4nHyXlqNwZPdpcQF/LT42zdEHNxrV48mvxlNRK8VY13fCtiLfAfeIUGftD47Aac8Oi7A/0mrP+YsNhIgl+ObBtepQ8cxNLy0pPnkBCv3zx27fokJqC9VIqoXgOENHIWrQY3qLi6woZu5C8OfPWCD2tkyLBUdzEhoBxAoGAFaohcuwLzSwhGPpcmsSk+SchBRIpocgpJGCVr/lYi2b6dS/SS99f7PlyIq6yVLDlGWF0+SMeBcBof+MFFQ+WoEDPUvtClKhZQHCjVgkPVgVGvAaf05/kKQUm1IoFU9qkRW3RN2oEhEFjKaSjyN1t7VHN5pCr3GRiiLYateBK9+kCgYEAsS/A+W7VY0NSxqpnrDx97p/Pv9WmYqxSZGGknuCulqCkvLDNeEeJv7lzEJcl/2sXkeiQMeaYjCrM18r0X4NgQNrVIQLygwS+gh8Uq3oeZzZOKvFpHbK78ry0RKi394+yDj8kQFrkdiFk8oSeMPbJt1ONxy25M6nkPn8iZ9M3qIs=";

    // 支付宝公钥
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnjiSXSWxqTiFp8T5kbcCPAnACXJ1Fa4YFcp5P+U8amuXkgjYE3LAmydIp8ZjtDgXgaSCfAPox7ym/W1xlOuCJWIlpi+1CfA0yZNAn2FOsEF9WJKgqFB06eStzIDd3cBvLs3wt2TC/qK5wTnxdmmPlZo8eVAweDK640MtREWSK4RmeKQfhvKmjSbFreDEo4JpRPMaKH6nL77UoknwG6k8UgJQ6/9Z6w7J6TKK0PLaofVmH27vq8agCpvxKOzLpo+d9y/DzDF1U+yLIt/9/O+i0BXHULfQJWhS1Nt3N74j42HoqjfFw0lVdquuxmn1Ud/WC1HmdhdnlDDqqoqdNOpIjQIDAQAB";

    // 服务器异步通知页面路径
    public static String notify_url = "";

    // 页面跳转同步通知页面路径
    public static String return_url = "http://localhost:8080/Kyzr2000/user/alipaySuccess";

    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

}
