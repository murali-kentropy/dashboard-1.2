


var assetjson = {
		 completeText: "Complete",
		 completedHtml: "Asset saved !",
		 pages: [
		         {
		          name: "page1",
		          elements: [
		           {
		            type: "dropdown",
		            name: "type",
		            title: "Type",
		            isRequired: true,
		            choices:typeList
		           },
		           {
		            type: "text",
		            name: "name",
		            title: "Name",
		            isRequired: true,
		            validators: [
		             {
		              type: "regex",
		              text: "Only alphanumeric, no space at the end",
		              regex: "^[\\w]+([-_\\s]{1}[a-zA-Z0-9]+)*$"
		             }
		            ]
		           },
		           {
		            type: "dropdown",
		            name: "assignedto",
		            title: "Assigned To",
		            isRequired: true,
		            choices:assignedtoList
		           },
		           {
		            type: "text",
		            name: "serial_no",
		            title: "Serial No",
		            validators: [
		             {
		              type: "regex",
		              text: "Enter only alphanumeric   ' / ' , ' - ' ,' ( ) ' , ' : '",
		              regex: "^([\\w,:()\\s/-]*)$"
		             }
		            ]
		           },
		           {
		            type: "text",
		            name: "model",
		            title: "Model",
		            validators: [
		             {
		              type: "regex",
		              text: "Enter only alphanumeric   ' / ' , ' - ' ,' ( ) ' , ' : '  ,  no space between",
		              regex: "^([\\w,:()/-]*)$"
		             }
		            ]
		           },
		           {
		            type: "dropdown",
		            name: "verified",
		            title: "Verified",
		            isRequired: true,
		            choices: [
		             "Yes",
		             "No"
		            ]
		           },
		           {
		            type: "dropdown",
		            name: "status",
		            visibleIf: "{verified} = \"Yes\"",
		            title: "Status",
		            isRequired: true,
		            choices: [
		             "Perfect",
		             "Absolute",
		             "Working",
		             "Not Working",
		             "Under-Repair",
		             "Defective (Stock)",
		             "Good"
		            ]
		           },
		           {
		            type: "dropdown",
		            name: "location",
		            title: "Location",
		            isRequired: true,
		            choices:locationList
		           }
		          ]
		         }
		        ]
		       }