<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CompanyFinder.aspx.cs" Inherits="WebApplication1.CompanyFinder" %>

<!DOCTYPE html>
<%
    //Fun Fake Data yay :D
    string[] ids = { "3449123-5", "3449147-2", "3449250-7" };
    string[] names = { "AnttiOy", "IsoPasi", "Group3" };
    string[] addresses = { "Mukkulankatu 15210", "Kauppakatu 15220 Lahti", "Lahdenkatu 15230 Lahti" };
    string[] dates = { "2026-10-29", "2026-10-28", "2026-10-27" };
    string start = Request.Form["start"];
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

    <div class ="field">
        <label for = "end"><strong> City</strong></label>
        <input id="end" class="rounded-box" placeholder="Select city (e.g. Helsinki, Lahti...)">
        <p>Please select a city</p>
    </div>


    <div class ="field">
        <label for = "end"><strong> Business Line</strong></label>
        <input id="end" class="rounded-box" placeholder="Select Businesss Line(e.g. IT Services)">
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
        <input id="end" class="rounded-box" placeholder="dd.mm.yyyy" type="date"> 
    </div>

    <div class="field">
        <label for="results"><strong>Max Results</strong></label>
        <input id="results" class="rounded-box" type="number" value="10">
    </div>

</div>
<!-- Button row-->
    <div class="row">
        <button type="submit" class="rounded-box btn search-companies">Search Companies</button>
        <button type ="submit" class ="rounded-box btn clear-filter">Clear Filters</button>
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
        <h2> Search Results </h2><table>
            <!--
            <thead>
            <tr>
                <th> Business ID </th>
                <th> Company Name </th>
                <th> Address </th>
                <th></th>
            </tr>
            </thead>
            <tbody>
                <tr>
                    <td> 3449123 - 5 </td>
                    <td> TahkoLuxuryVillas Oy </td>
                    <td> Mukkulankatu 15210 </td>
                    <td class="table.arrow"> › </td>
                </tr>

                <tr>
                    <td> 3449147 - 2 </td>
                    <td> Sporttiolo Oy </td>
                    <td> Kauppakatu 15220 Lahti </td>
                    <td class="table.arrow"> › </td>
                </tr>

                <tr>
                    <td> 3449250 - 7 </td>
                    <td> Tiimihenki Oy </td>
                    <td> Lahdenkatu 15230 Lahti </td>
                    <td class="table.arrow"> › </td>
                </tr>
                
            </tbody>                    
         </table>  
        -->
        <table>
            <thead>
            <tr>
                <%
                    if (Request.Form.Count > 0)
                    {
                        for (int i = 0; i < names.Length; i++)
                        {
                            if (dates[i] == start)
                            {
                                Response.Write("<tr>");
                                Response.Write("<td>" + ids[i] + "</td>");
                                Response.Write("<td>" + names[i] + "</td>");
                                Response.Write("<td>" + addresses[i] + "</td>");
                                Response.Write("<td class=\"table.arrow\"> &rsaquo; </td>");
                                Response.Write("</tr>");
                            }
                        }
                        Response.Write("For demo purposes, pick a date between 27th, 28th or 29th of October 2026 (aka 27.10.2026, 28.10.2026 or 29.10.2026)");
                    }
                %>
            </tbody>                    
         </table>  

        <!-- In Case: No Search performed 
        <table>
            <tr>
                <td class="empty-title>"> No Search performed yet! </td>
            </tr>

            <tr>
                <td class="empty-description"> Enter your search criteria above to find Finnish registered companies. 
                    You can filtered by city, industry, and registration date. </td>
            </tr>
        </table>
        -->

        
     </section>   
    </form>
</body>
</html>
