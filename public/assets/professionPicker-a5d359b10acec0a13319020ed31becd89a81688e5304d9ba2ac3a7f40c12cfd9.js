$("#general_info_industry").on("change",function(){const e=["Brand Owner","Designer","Other Creator"],n=["Model","Photographer","Sales","Marketing","Retail","Visual","Content Creator","Blogger","Influencer","Forecasting","Finances","Other Services"],o=["Manufacturing","Materials","Other Makers"];var a=$(this).val();if(console.log("Four friends"),$("#general_info_job_name option").hide(),"Creators"==a){$("#general_info_job_name").append("<option>Select One</option>");for(var i=0;i<3;i++)$("#general_info_job_name").append("<option>"+e[i]+"</option>")}else if("Services"==a){$("#general_info_job_name").append("<option>Select One</option>");for(i=0;i<12;i++)$("#general_info_job_name").append("<option>"+n[i]+"</option>")}else if("Makers"==a){$("#general_info_job_name").append("<option>Select One</option>");for(i=0;i<3;i++)$("#general_info_job_name").append("<option>"+o[i]+"</option>")}else $("#general_info_job_name option").show()});