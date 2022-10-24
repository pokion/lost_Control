/**
 * Created by cezary.bubieniec on 10.10.2022.
 */

public with sharing class LCTRL_Helper {

    public static String buildPublicUrl(ContentDistribution cDist) {
        String fileType = cDist.ContentVersion.FileType.toLowerCase().capitalize();
        String cVersionId = cDist.ContentVersion.Id;
        String cBodyId = cDist.ContentVersion.ContentBodyId;
        String originalUrl = String.valueOf(cDist.DistributionPublicUrl);
        String cDistParam = originalUrl.substring(originalUrl.indexOf('/a/'));
        String orgId = ConnectApi.Organization.getSettings().orgId;
        String baseDomain = Url.getOrgDomainUrl().toExternalForm();
        baseDomain = baseDomain.substringBefore('.') + '--c.documentforce.com';
        String theUrl = baseDomain + '/sfc/dist/version/renditionDownload?rendition=ORIGINAL_' +
                fileType + '&versionId=' + cVersionId + '&operationContext=DELIVERY&contentId=' + cBodyId +
                '&page=0&d=' + cDistParam + '&oid=' + orgId + '&dpt=null&viewId=';
        return theUrl;
    }

    public static Map<Id, ContentDistribution> getMapOfContentDistribution(List<ContentDistribution> cDists){
        Map<Id, ContentDistribution> cDistReturn = new Map<Id, ContentDistribution>();
        System.debug(cDists);
        for(ContentDistribution cDist : cDists){
            cDistReturn.put(cDist.ContentVersion.Id, cDist);
        }

        return cDistReturn;
    }
}