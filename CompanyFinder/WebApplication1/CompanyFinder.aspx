<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyFinder.aspx.cs" Inherits="WebApplication1.CompanyFinder" %>
<%@ Import Namespace="System" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="WebApplication1" %>

<!DOCTYPE html>
<%
string action = Request.Form["action"];
if (action == null)
{
    action = "";
}

    string start = Request.Form["start"];
    if (start == null)
    {
        start = "";
    }


    // City after parsing
    string city = Request.Form["city"];
    if (city == null)
    {
        city = "";
    }
 city = city.Trim();

    // Business Line: value = full 5-digit TOL industry code (what the PRH API filters on)
    string[,] businessLineOptions = {
        { "62100", "Software development" },
        { "62200", "IT consulting" },
        { "25620", "Machining (manufacturing)" },
        { "16239", "Carpentry & joinery (manufacturing)" },
        { "13920", "Household textiles" },
        { "14290", "Clothing manufacturing" },
        { "01110", "Cereal farming" },
        { "81100", "Facility services" },
        { "81210", "Building cleaning" },
        { "56101", "Restaurants" },
        { "43210", "Electrical installation" }
    };

    string businessLine = Request.Form["businessLine"];

if (businessLine == null)
{
    businessLine = "";
}
businessLine = businessLine.Trim();
string businessLineCode = "";

for (int b = 0; b < businessLineOptions.GetLength(0); b++)
{
    if (string.Equals(
        businessLine,
        businessLineOptions[b, 1],
        StringComparison.OrdinalIgnoreCase))
    {
        businessLineCode = businessLineOptions[b, 0];
    }
}

bool validBusinessLine = businessLineCode != "";

    string end = Request.Form["end"];
        if (end == null)
    {
        end = "";
    }
    // Max Results
    string maxInput = Request.Form["results"];
    if (maxInput == "")
    {
        maxInput = "10";
    }
    int maxResults;

    if (!int.TryParse(maxInput, out maxResults))
    {
        maxResults = 10;
    }
    else if (maxResults < 1)
    {
        maxResults = 1;
    }
    else if (maxResults > 10)
    {
        maxResults = 10;
    }

if (action == "clear")
{
    start = "";
    city = "";
    businessLine = "";
    end = "";
    maxResults = 10;
}

%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title data-i18n="home.meta.title">Company Finder</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <form id="form1" method="post">
    <header class="page-header">
    <h1>Company Information Retriever</h1>
    <p>Find potential business customers in Finland.</p>
    </header>

        <div class="content">

<!-- Left Panel -->
<div class="left-panel">
        
    <div class="field">
    </div>
    <div class="field">
    </div>

<!-- The dates and results row. "row" creates it. -->
 <!--first row-->
<div class="row first-row">  

    <div class="field">
        <label for="city"><strong>City</strong></label>
        <input id="city" name="city" class="rounded-box" placeholder ="Please write a city" value="<%= city %>"/>
    </div>


    <div class="field">
        <label for="businessLine"><strong>Business Line</strong></label>
         <input id="businessLine" name="businessLine" class="rounded-box" list="businessLineList" placeholder="Type or select a business line" value="<%= Server.HtmlEncode(businessLine) %>" required />

    <datalist id="businessLineList">
        <% for (int b = 0; b < businessLineOptions.GetLength(0); b++) { %>
            <option value="<%= businessLineOptions[b, 1] %>"></option>
        <% } %>
    </datalist>
    </div>
</div>

<!--second row-->
<div class="row">  


    <div class ="field">
        <label for = "start"><strong> Registration Start Date</strong></label>
        <input id="start" name="start" class="rounded-box" type="date" value="<%= start %>">
         </div>

    <div class="field">
        <label for="end"> <strong>Registration End Date</strong></label>
        <input id="end" name="end" class="rounded-box" placeholder="dd.mm.yyyy" type="date" value="<%= end %>"> 
    </div>

    <div class="field">
        <label for="results"><strong>Max Results</strong></label>
        <input id="results" name ="results" class="rounded-box" min="1" max="10" type="number" value="<%= maxResults %>">
    </div>

</div>
<!-- Button row-->
    <div class="row">
        <button type="submit" name="action" value="search" class="rounded-box btn search-companies">Search Companies</button>
        <button type ="submit" name="action" value="clear" formnovalidate class ="rounded-box btn clear-filter">Clear Filters</button>
     </div>
</div>
    <!-- Recent Results -->

    <aside class="recent-results">

        <h2 class="recent-title">
            <span class="clock-icon">&#9719;</span>
            Recent Results
        </h2>

        <div class="recent-card">

            <div class="recent-info">
                <div class="recent-details">
                    <span class="clock-icon">&#9719;</span>
                    <strong>Helsinki</strong>
                    <span>•</span>
                    <strong>IT</strong>
                    <span>•</span>
                    <span>01.09.2024 - 01.10.2024</span>
                </div>

                <p class="recent-meta">
                    <span>12 results</span>
                    <span>2 days ago</span>
                </p>
            </div>

            <span class="recent-arrow">&rsaquo;</span>

        </div>

        <div class="recent-card">

            <div class="recent-info">
                <div class="recent-details2">
                    <span class="clock-icon">&#9719;</span>
                    <strong>Lahti</strong>
                    <span>•</span>
                    <strong>Manufacturing</strong>
                    <span>•</span>
                    <span>01.09.2024 - 01.10.2024</span>
                </div>

                <p class="recent-meta">
                    <span>8 results</span>
                    <span>1 day ago</span>
                </p>
            </div>

            <span class="recent-arrow">&rsaquo;</span>

        </div>

    </aside>
</div>

        
    <!-- Search Result -->
    <section class="result"> 
        <h2> Search Results </h2>
<table>
            
            <thead>
            <tr>
                <th> Business ID </th>
                <th> Company Name </th>
                <th> Address </th>
                <th></th>
            </tr>
            </thead>
   
        
            <tbody>
                <%
                    if (Request.HttpMethod != "POST" || action == "clear")
                    {
                        Response.Write("<tr>");
                        Response.Write("<td colspan='4'>Enter your search criteria above to find Finnish registered companies.</td>");
                        Response.Write("</tr>");
                    }
                    else if (start != "" && end != "" && string.Compare(start, end) > 0)
                    {
                        Response.Write("<tr><td colspan='4'>Start date cannot be later than end date.</td></tr>");
                    }
else if (city == "")
{
    Response.Write("<tr><td colspan='4'>Please select a City before searching.</td></tr>");
}
else if (!validBusinessLine)
{
    Response.Write("<tr><td colspan='4'>Please select a valid Business Line before searching.</td></tr>");
}
                    else
                    {
                        // Create the PRH API URL
                        string url = "https://avoindata.prh.fi/opendata-ytj-api/v3/companies";

                        bool hasParameter = false;

                        if (city != "")
                        {
                            url = url + "?location=" + Server.UrlEncode(city);
                            hasParameter = true;
                        }

                        if (end != "")
                        {
                            if (hasParameter)
                            {
                                url = url + "&registrationDateEnd=" + Server.UrlEncode(end);
                            }
                            else
                            {
                                url = url + "?registrationDateEnd=" + Server.UrlEncode(end);
                                hasParameter = true;
                            }
                        }

                        if (start != "")
                        {
                            if (hasParameter)
                            {
                                url = url + "&registrationDateStart=" + Server.UrlEncode(start);
                            }
                            else
                            {
                                url = url + "?registrationDateStart=" + Server.UrlEncode(start);
                                hasParameter = true;
                            }
                        }

                        
                            if (hasParameter)
                            {
                                url = url + "&mainBusinessLine=" + Server.UrlEncode(businessLineCode);
                            }
                            else
                            {
                                url = url + "?mainBusinessLine=" + Server.UrlEncode(businessLineCode);
                                hasParameter = true;
                            }
                        
                        // Get data from PRH
                        string responseFromServer = "";
                        bool requestFailed = false;
                        try
                        {
                            WebRequest myRequest = WebRequest.Create(url);
                            WebResponse myResponse = myRequest.GetResponse();

                            Stream dataStream = myResponse.GetResponseStream();
                            StreamReader reader = new StreamReader(dataStream);

                            responseFromServer = reader.ReadToEnd();

                            reader.Close();
                            myResponse.Close();
                        }
                        catch (WebException)
                        {
                            requestFailed = true;
                        }

                        // Parse the response (the parsing code is in ResponseParser.cs)
                        if (requestFailed)
{
    Response.Write("<tr><td colspan='4'>Could not get data from PRH. Please try again later.</td></tr>");
}
else
{
    List<Company> companies = ResponseParser.ParseCompanies(responseFromServer, maxResults);

    foreach (Company company in companies)
    {
        Response.Write("<tr>");
        Response.Write("<td>" + Server.HtmlEncode(company.BusinessId) + "</td>");
        Response.Write("<td>" + Server.HtmlEncode(company.Name) + "</td>");
        Response.Write("<td>" + Server.HtmlEncode(company.Address) + "</td>");
        Response.Write("<td class=\"table.arrow\"> &rsaquo; </td>");
        Response.Write("</tr>");
    }

    if (companies.Count == 0)
    {
        Response.Write("<tr><td colspan='4'>No companies found.</td></tr>");
    }
}
                    }
                %>
            </tbody>                    
         </table>  

        

        
     </section>   
    </form>
</body>
</html>
