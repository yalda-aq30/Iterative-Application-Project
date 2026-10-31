using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class CompanyFinder : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
            string[] ids = { 
                "3449123-5",
                 "3449147-2", 
                 "3449250-7", "1234567-4", 
                 "123033-1", "234944-2", 
                 "394994-2"
                };

            string[] names = { 
                "AnttiOy",
                 "IsoPasi", 
                 "Group3", 
                 "PenttiOy", 
                 "YaldaOy", 
                 "KHANNOy", 
                 "AliOy"
                };

            string[] addresses = { 
                "Mukkulankatu 15210",
                 "Kauppakatu 15220 Lahti", 
                 "Lahdenkatu 15230 Lahti", 
                 "Aleksanterinkatu 15210 Lahti", 
                 "Tekniikankatu 33720 Tampere", 
                 "Vaksokatu 15230 Lahti",
                 "Ylipintokatu 15230 Lahti"
                 };
                
            string[] dates = { 
                "2026-10-29", 
                "2026-10-28", 
                "2026-10-27",
                "2026-10-21",
                "2026-10-13",
                "2026-10-20",
                "2026-10-21"
                
                };

            string start = Request.Form["start"];


            string[] businessLines = { 
                "IT Services",
                 "Manufacturing",
                 "IT Services",
                  "Textile", 
                  "Agriculture",
                   "Facility services", 
                   "Faschion"
                   };

                   
            string businessLine = Request.Form["businessLine"];


            // Filter companies after form submission
            if (IsPostBack)
            {
                for (int i = 0; i < names.Length; i++)
                {
                    bool businessLineMatch =
                        string.IsNullOrWhiteSpace(businessLine) ||
                        businessLines[i].IndexOf(
                            businessLine,
                            StringComparison.OrdinalIgnoreCase) >= 0;

                    bool dateMatch =
                        string.IsNullOrWhiteSpace(start) ||
                        dates[i] == start;

                    if (businessLineMatch && dateMatch)
                    {
                        System.Diagnostics.Debug.WriteLine(
                            ids[i] + " - " +
                            names[i] + " - " +
                            addresses[i] + " - " +
                            dates[i] + " - " +
                            businessLines[i]);
                    }
                }
                
            }
        
        }
    }
}