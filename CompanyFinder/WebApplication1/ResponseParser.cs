using System.Collections.Generic;

namespace WebApplication1
{
    // One company read from the PRH API response
    public class Company
    {
        public string BusinessId { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
    }

    // Reads the JSON text the PRH API sends back (responseFromServer) and turns it into companies.
    // The JSON looks like: {"totalResults":239,"companies":[{"businessId":{...},"names":[...],...},{"businessId":...}]}
    public static class ResponseParser
    {
        // Returns at most maxResults companies from the response
        public static List<Company> ParseCompanies(string responseFromServer, int maxResults)
        {
            List<Company> companies = new List<Company>();

            if (string.IsNullOrEmpty(responseFromServer))
            {
                return companies;
            }

            // Every company starts with "businessId", so we cut the text into one piece per company
            int position = responseFromServer.IndexOf("\"businessId\"");

            while (position != -1 && companies.Count < maxResults)
            {
                int nextPosition = responseFromServer.IndexOf("\"businessId\"", position + 1);
                int endPosition = nextPosition;
                if (nextPosition == -1)
                {
                    endPosition = responseFromServer.Length;
                }
                string companyText = responseFromServer.Substring(position, endPosition - position);

                Company company = new Company();

                // The first "value" is the business ID, the first "name" is the company name
                company.BusinessId = GetJsonText(companyText, "value");
                company.Name = GetJsonText(companyText, "name");
                company.Address = GetFirstAddress(companyText);

                companies.Add(company);

                position = nextPosition;
            }

            return companies;
        }

        // Builds "Street 1, 15110 CITY" from the company's first address
        // (the street address, or the postal address if there is no street address)
        private static string GetFirstAddress(string companyText)
        {
            int addressPosition = companyText.IndexOf("\"addresses\"");
            if (addressPosition == -1)
            {
                return "";
            }

            // Cut out only the first address, so we never mix in parts of the second one
            string addressText = companyText.Substring(addressPosition);
            int secondAddress = addressText.IndexOf("},{\"type\"");
            if (secondAddress != -1)
            {
                addressText = addressText.Substring(0, secondAddress);
            }

            string street = GetJsonText(addressText, "street");
            string buildingNumber = GetJsonText(addressText, "buildingNumber");
            string postCode = GetJsonText(addressText, "postCode");
            string city = GetJsonText(addressText, "city");

            string streetPart = (street + " " + buildingNumber).Trim();
            string cityPart = (postCode + " " + city).Trim();

            if (streetPart != "" && cityPart != "")
            {
                return streetPart + ", " + cityPart;
            }
            return streetPart + cityPart;
        }

        // Finds "key":"some text" in the JSON and returns: some text
        // Returns "" when the key is not found.
        private static string GetJsonText(string json, string key)
        {
            string search = "\"" + key + "\":\"";
            int keyPosition = json.IndexOf(search);
            if (keyPosition == -1)
            {
                return "";
            }

            int textStart = keyPosition + search.Length;
            int textEnd = json.IndexOf("\"", textStart);

            // A quote inside the text is written as \" so skip those
            while (textEnd > 0 && json[textEnd - 1] == '\\')
            {
                textEnd = json.IndexOf("\"", textEnd + 1);
            }
            if (textEnd == -1)
            {
                return "";
            }

            return json.Substring(textStart, textEnd - textStart).Replace("\\\"", "\"");
        }
    }
}
