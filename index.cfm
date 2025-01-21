
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>File Manager</title>
		<style>
			body { font-family: Arial, sans-serif; margin: 20px; }
			table { width: 100%; border-collapse: collapse; }
			th, td { padding: 8px 12px; border: 1px solid #ccc; }
			th { background-color: #f4f4f4; }
			.actions a { margin-right: 5px; }
			.folder-navigation { margin-bottom: 20px; }
		</style>
	</head>
	<cfoutput>
	
	<cfset vle_temp_script_name = "#CGI.SCRIPT_NAME#">
	<cfset vle_temp_current_filename = '#ListLast(vle_temp_script_name, "/\")#'>
	
	<body>
		<h1>File Manager</h1>
		
		<div class="folder-navigation">
			<form method="get" action="#vle_temp_current_filename#">
				<label for="folder">Current Folder:</label>
				<input type="text" id="folder" name="folder" value="#(StructKeyExists(URL, 'folder') ? URL.folder : './')#" required>
				<button type="submit">Change Folder</button>
			</form>
		</div>
		<cfif isDefined("folder")>
			<form action="#vle_temp_current_filename#" method="post" enctype="multipart/form-data">
				<input type="file" name="uploadFile" required>
				<cfif StructKeyExists(URL, "folder")>
					<input type="hidden" name="folder" value="#URL.folder#">
				<cfelse>
					<input type="hidden" name="folder" value=".">
				</cfif>
				<button type="submit" name="upload">Upload</button>
			</form>
			
			<cfset currentPath = (StructKeyExists(URL, "folder") ? expandPath(URL.folder) : expandPath("."))>
			
			<cfif StructKeyExists(form, "upload")>
				<cfif not DirectoryExists(currentPath)>
					<cfdirectory action="create" directory="#currentPath#">
				</cfif>
				<cffile action="upload" file="uploadFile" destination="#currentPath#" nameConflict="makeunique">
				<cfif StructKeyExists(cffile, "serverFile")>
					<p>File #cffile.serverFile# uploaded successfully.</p>
				<cfelse>
					<p>Upload failed. Please try again.</p>
				</cfif>
			</cfif>
			
			<h2>Contents of "#Replace((StructKeyExists(URL, 'folder') ? URL.folder : './'), '../', '')#"</h2>
			<cfset items = directoryList(currentPath, false, "query")>
			<table>
				<tr>
					<th>Filename</th>
					<th>Type</th>
					<th>Size (KB)</th>
					<th>Actions</th>
				</tr>
				<cfif items.recordCount gt 0>
					<cfloop query="items">
						<tr>
							<td>
								<cfif items.type EQ "Dir">
									<a href="#vle_temp_current_filename#?folder=#URLencode((items.type EQ "Dir" ? items.directory & '/' : '') & name)#">📁 #name#</a>
								<cfelse>
									#name#
								</cfif>
							</td>
							<td>
								<cfif items.type EQ "Dir">
									Folder
								<cfelse>
									File
								</cfif>
							</td>
							<td>
								<cfif items.type EQ "Dir">
									-
								<cfelse>
									#NumberFormat(size / 1024, "9,999")#
								</cfif>
							</td>
							<td class="actions">
								<cfif items.type EQ "Dir">
									
								<cfelse>
									<a href="#(StructKeyExists(URL, 'folder') ? URL.folder & '/' : '')##name#" download>Download</a>
									<cfif isDefined("del_yn") AND del_yn EQ "y">
										<a href="#vle_temp_current_filename#?folder=#URLencode(URL.folder)#&delete=#URLencode(name)#" onclick="return confirm('Delete this file?');">Delete</a>
									</cfif>
								</cfif>
							</td>
						</tr>
					</cfloop>
				<cfelse>
					<tr>
						<td colspan="4">No items found.</td>
					</tr>
				</cfif>
			</table>
			
			<cfif StructKeyExists(URL, "delete")>
				<cfset deleteFile = (StructKeyExists(URL, "folder") ? expandPath(URL.folder & "/" & URL.delete) : expandPath(URL.delete))>
				<cfif FileExists(deleteFile) AND NOT DirectoryExists(deleteFile)>
					<cffile action="delete" file="#deleteFile#">
					<p>File #URL.delete# deleted.</p>
					<cflocation url="#vle_temp_current_filename#?folder=#URLencode(URL.folder)#" addtoken="no">
				<cfelse>
					<p>File not found or is a folder.</p>
				</cfif>
			</cfif>
		</cfif>
	</body>
</cfoutput>
</html>