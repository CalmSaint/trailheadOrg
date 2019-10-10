public class ParkLocator {
    public static List<String> country(String cntry){
        ParkService.ParksImplPort parks=new ParkService.ParksImplPort();
        return parks.byCountry(cntry);
    }

}