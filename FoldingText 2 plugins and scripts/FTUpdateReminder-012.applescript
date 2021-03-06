property pTitle : "Adjust Reminder from FoldingText 2"
property pVer : "0.12"
-- Author Rob Trew, license MIT
-- Provisional version -- refactoring to 1. check and report on plugin installation
-- and 2. call plugin functions directly (rather than invoke a command and set a global)
property pstrApp : "FoldingText"


-- THIS SCRIPT REQUIRES up to date versions of TWO PLUGINS TO BE INSTALLED
-- (a dialog will prompt for any plugin which needs to be installed or upgraded)
property pstrRTPluginFolder : "FoldingText 2 plugins and scripts"
property pRTPluginLink : "https://github.com/RobTrew/tree-tools"
property plstPlugins : {¬
	{|name|:"reminder tools", |version|:0.2, |URL|:pRTPluginLink, |folder|:pstrRTPluginFolder}, ¬
	{|name|:"smalltime", |version|:0.2, |URL|:pRTPluginLink, |folder|:pstrRTPluginFolder}}

-- 1. COPY THE TWO FOLLOWING PLUGIN FOLDERS AND THEIR CONTENTS TO THE  FOLDINGTEXT PLUG-IN DIRECTORY
-- ( From the FoldingText menu: File > Open Application Folder )

----- reminder tools.ftplugin
----- smalltime.ftplugin

-- (both of these plugin folders can be found at
-- https://github.com/RobTrew/tree-tools/tree/master/FoldingText%202%20plugins%20and%20scripts
-- Download https://github.com/RobTrew/tree-tools/archive/master.zip
-- Unzip the archive, and copy the 2 .ftplugin folders from:
--	--	-- tree-tools-master/FoldingText 2 plugin and scripts
-- into the FT Application folder's Plug-ins subfolder.
--)

-- CLOSE & RESTART FoldingText 2

-- 2. CHOOSE A TAG TO HOLD YOUR REMINDER DATE / TIMES ( DEFAULT IS "@alarm" )
property pstrRemindTag : "@alarm" --

-- 3. ADD ANY OTHER DATE TAGS WHICH YOU WOULD LIKE THE SCRIPT TO READ AND UPDATE TO THE FOLLOWING LIST
--	('read and update' = translate any informal or relative expression to standard yyyy-mm-dd [HH:MM])
property plstOtherDateTags : {}

-- 4. EDIT THE FOLLOWING LIST, CHOOSING 3 @tag or @tag(value) PRIORITY LEVELS, *IN DESCENDING ORDER*
--  (Reminders.app only offers three levels of priority)
-- 1 to 3 @tags or @key(value) pairs eg  ,{"@hi", "@med", "@lo"} {"@priority(0)", "@priority(1)", "@priority"}
-- in descending priority. If you use 4 or more tags, the fourth onwards will be treated as
-- alternative indications of the lowest (third) priority
property plstHeatTags : {"@priority(1)", "@priority(2)", "@priority(3)", "@priority"}

-- 5. CHOOOSE AN MD LINK LABEL FOR THE PLAIN TEXT LINKS TO REMINDERS.APP ENTRIES
-- property pLinkLabel :"🔔" -- a possible link label for the pictorially inclined :-)
-- property pLinkLabel :"日" -- day/date (CJK graphic economy)
property pLinkLabel : "alert" -- [reminder](uuid) -- text label for the MD link

-- Include links to NvAlt and/or Editorial in the Reminder Note ?
-- 6. EDIT THE FOLLOWING VALUES TO INCLUDE OR SKIP LINKS BACK TO PLAIN TEXT FILES IN NVALT OR EDITORIAL for iOS
property pblnNVAltLink : true
property pblnEditorialLink : true

-- See, for this pattern:http://editorial-app.appspot.com/workflow/5822792658321408/6bhzGfAOGVM
property pWorkFlow : "getUUID"
property pURL_NV : "nvalt://"
property pURLNoteLink : "editorial://?command=" & pWorkFlow & "&input="

-- 7. EDIT THE FOLLOWING VALUE TO INCLUDE OR SKIPP LOGGING OF DATE CHANGES IN THE REMINDERS.APP NOTE
-- Log date changes to the end of the Reminder note ?
property pblnLogDateDeltas : true

-- 8. TO SPECIFY A PARTICULAR REMINDERS LIST (RATHER THAN THE DEFAULT LIST): 
--	  edit the value of pRemindersListName below to the name of your target list in Reminders.app
property pRemindersListName : "" -- leave empty to use default list in Reminders.app


-- Don't edit these properties - the script depends on them :-)
property precDateFields : {alarm:pstrRemindTag, others:plstOtherDateTags, heat:plstHeatTags}
property pUnixEpoch : missing value
property plstHeatValue : {1, 5, 9} -- values used by Reminders.app

on run
	-- ADJUST AND READ TEXT DATES, AND ANY UUID AND PRIORITY,
	tell application "FoldingText"
		set lstDocs to documents
		if lstDocs ≠ {} then
			tell item 1 of lstDocs
				-- DO WE HAVE THE PLUGINS WHICH WE NEED ?
				set lstloadedPlugins to my loadedPlugins(it)
				set lstMissing to {}
				repeat with i from 1 to length of plstPlugins
					set varPath to contents of (item i of lstloadedPlugins)
					if class of (varPath) is not text then
						set end of lstMissing to ((item i of plstPlugins) & {problem:varPath})
					end if
				end repeat
				
				if lstMissing ≠ {} then
					my pointUserToPlugins(lstMissing)
				else
					-- IN THE SELECTED LINE, TRANSLATE ANY INFORMAL DATES/ADJUSTMENTS 
					-- AND READ THE TEXT AND ANY UUID, DATE, PRIORITIES
					set recNode to (evaluate script "function(editor, options) {
						'use strict'
						// call a 'reminder tools' plugin function to update and read the line						
						return require(options.pluginPath).updateAndReadForLink(options);
					}" with options precDateFields & {pluginPath:item 1 of lstloadedPlugins})
					
					-- AND UPDATE OR CREATE A LINKED REMINDER FOR THE SELECTED LINE
					my updateOrCreateReminder(it, recNode)
				end if
			end tell
		end if
	end tell
end run

------

on updateOrCreateReminder(oDoc, recNode)
	-- Update existing reminder, or make a new one
	-- and create a new list, if pRemindersListName is not empty,
	-- and no matching list is found
	
	
	if pUnixEpoch is missing value then set pUnixEpoch to UnixEpoch()
	set blnNewList to false
	tell application "Reminders"
		set varUUID to uuid of recNode
		set blnLinked to (varUUID ≠ null)
		if blnLinked then -- check that the record still exists
			try
				set oRem to reminder id varUUID
			on error
				display alert "Reminder not found for this UUID"
				return
				--set blnLinked to false
			end try
		end if
		
		set dteOldAlarm to missing value
		if blnLinked then
			tell oRem
				-- Update the alarm,
				set varVal to alarm of recNode
				if varVal is not null then
					set dteOldAlarm to remind me date
					set remind me date to (pUnixEpoch + varVal)
				end if
				-- the priority
				set varVal to heat of recNode
				if varVal is not null then
					set lngHeat to item varVal of plstHeatValue
				else
					set lngHeat to 0
				end if
				
				if its priority ≠ lngHeat then set its priority to lngHeat
				
				-- and the text.
				set strText to |text| of recNode
				set strName to its name
				if strName does not contain strText then ¬
					set name to strText & linefeed & strName
				set oList to container
			end tell
		else
			-- Text
			set recNew to {name:|text| of recNode}
			set varVal to alarm of recNode
			-- Alarm
			if varVal is not null then set recNew to recNew & {remind me date:(pUnixEpoch + varVal)}
			-- Note
			
			set oList to missing value
			if pRemindersListName ≠ "" then
				try
					set oList to list named pRemindersListName
				on error
					set oList to make new list with properties {name:pRemindersListName}
					set blnNewList to true
				end try
			end if
			if oList is missing value then set oList to default list
			
			tell oList to set oRem to (make new reminder with properties recNew)
			tell oRem
				set varUUID to id
				set strUUID to text -36 thru -1 of varUUID
				if pblnNVAltLink then
					set body to linefeed & linefeed & pURL_NV & strUUID
				end if
				if pblnEditorialLink then
					set body to body & linefeed & linefeed & pURLNoteLink & strUUID
				end if
			end tell
		end if
		
		tell oRem
			set dteAlarm to due date
			if pblnLogDateDeltas then
				if (dteOldAlarm ≠ dteAlarm) then
					set body to body & linefeed & my changeLog(dteOldAlarm, dteAlarm, iso of recNode)
				end if
			end if
		end tell
	end tell
	
	-- if the Reminder is new, add a link to the FT item
	
	if not blnLinked then
		tell application "FoldingText"
			tell oDoc
				(evaluate script "function(editor, options) {
					'use strict'
					var tree = editor.tree(),
						node = editor.selectedRange().startNode;
					tree.beginUpdates();
						node.setText(node.text() +  ' [' + options.linkname + '](' + options.uuid + ')' )
					tree.endUpdates();
					tree.ensureClassified();
				}" with options {uuid:varUUID, linkname:pLinkLabel})
			end tell
		end tell
		set strMsg to "Created"
	else
		set strMsg to "Updated"
	end if
	set strMsg to strMsg & " [" & name of oList & "]"
	
	set varDateSource to datetext of recNode
	if varDateSource is not null then
		set strPrefix to ""
		if first character of pstrRemindTag ≠ "@" then set strPrefix to "@"
		set strMsg to strMsg & space & strPrefix & ¬
			pstrRemindTag & "(" & varDateSource & ")"
	end if
	
	if dteAlarm is missing value then set dteAlarm to |text| of recNode
	display notification strMsg with title pTitle subtitle dteAlarm as string
	if blnNewList then
		display dialog "New list created in Reminders.app:" & linefeed & linefeed & tab & pRemindersListName & ¬
			linefeed & linefeed & "(based on `pRemindersListName` at the top of this script)" buttons {"OK"} ¬
			default button "OK" with title pTitle & "  ver. " & pVer
	end if
end updateOrCreateReminder

on pointUserToPlugins(lstMissing)
	-- TELL THE USER WHERE TO FIND THE REQUIRED PLUGINS
	set lngMissing to length of lstMissing
	
	set lstMenu to {}
	set lngDigits to length of (lngMissing as string)
	
	repeat with i from 1 to lngMissing
		tell (item i of lstMissing) as record
			set strItem to my padnum(i, lngDigits) & tab & its |name| & ":" & tab
			if its problem is null then
				set strItem to strItem & "not installed"
			else
				set strItem to strItem & "needs version " & its |version| & " (upgrade from " & its problem & ")"
			end if
		end tell
		set end of lstMenu to strItem
	end repeat
	
	set strMsg to (lngMissing as string) & space & pl("plugin", lngMissing) & space & apl("need", lngMissing) & ¬
		" to be installed or upgraded." & linefeed & linefeed & ¬
		"1. Copy each .ftplugin folder to:" & linefeed & tab & pstrApp & " > File > Application Folder" & linefeed & linefeed & ¬
		"2. Close and reststart  " & pstrApp & linefeed
	
	tell application "FoldingText"
		activate
		set varChoice to choose from list lstMenu with title pTitle & tab & pVer with prompt ¬
			strMsg default items {item 1 of lstMenu} ¬
			OK button name "Go to plugins page for selected item" cancel button name ¬
			"Cancel" with empty selection allowed without multiple selections allowed
		if varChoice = false then
			set lngChoice to 0
		else
			set {dlm, my text item delimiters} to {my text item delimiters, tab}
			set lngChoice to (first text item of (item 1 of varChoice)) as integer
			set my text item delimiters to dlm
			do shell script "open " & quoted form of |url| of (item lngChoice of plstPlugins)
		end if
		return lngChoice
	end tell
	
end pointUserToPlugins

-- CHECK
--property plstPlugins : {¬
--	{name:"reminder tools", version:0.2, URL:pRTPluginLink, folder:pstrRTPluginFolder}, ¬
--	{name:"smalltime", version:0.2, URL:pRTPluginLink, folder:pstrRTPluginFolder} ¬
on loadedPlugins(oDoc)
	-- CHECK THAT REQUIRED PLUGINS ARE INSTALLED AND UP TO DATE
	tell application "FoldingText"
		tell oDoc
			set lstloadedPlugins to (evaluate script "
				function(editor, options) {
					'use strict'
					// check for plugins
					var	fnQuery = require('ft/util/queryParameter').QueryParameter,
						lstPlugins = fnQuery('pluginPaths', '').split(':'),
						lstFound = [];
						options.needed.forEach(function(dctPlugin) {
							var strFolder = '/Plug-Ins/' + dctPlugin.name + '.ftplugin/',
								lngPlugins = lstPlugins.length, strPluginPath,
								blnFound, i, oPlugin;
							for (i=0; i<lngPlugins; i++) {
								strPluginPath = lstPlugins[i];
								blnFound = (strPluginPath.indexOf(strFolder) !== -1);
								if (blnFound) {
									// check whether the plugin is up to date
									oPlugin = require(strPluginPath);
									if (oPlugin.version >= dctPlugin.version) {
										lstFound.push(strPluginPath);
									} else {
										lstFound.push(oPlugin.version);
									}
									break;
								}
							}
							if (!blnFound) {lstFound.push(null);}
						});
					return lstFound;
				}" with options {needed:plstPlugins})
		end tell
	end tell
	return lstloadedPlugins
end loadedPlugins

on changeLog(dteOldAlarm, dteAlarm, strISO)
	if dteOldAlarm is not missing value then
		set rDelta to dteAlarm - dteOldAlarm
		if rDelta > 0 then
			set strDirn to "deferred "
		else
			set strDirn to "brought ahead "
		end if
		set blnTime to (abs(rDelta) < days)
		if blnTime then
			if time of dteOldAlarm = 0 then
				set strDirn to "set to "
			else if time of dteAlarm = 0 then
				set strMsg to "Time cleared"
				set blnTime to false
			end if
			
			if blnTime then
				set strHours to abs(rDelta div 3600) as string
				set strMins to abs(rDelta mod 3600) div 60 as string
				set strMsg to strDirn & strHours & "h"
				if strMins ≠ "0" then set strMsg to strMsg & strMins & "m"
			end if
		else
			set strMsg to strDirn & abs(rDelta div days) & "d"
		end if
		set strPrepn to "→"
	else
		set strMsg to " created for "
		set strPrepn to ""
	end if
	
	return "[log:" & short date string of (current date) & "] " & strMsg & strPrepn & strISO
end changeLog

on abs(varN)
	if varN < 0 then
		return -varN
	else
		return varN
	end if
end abs

on UnixEpoch()
	tell (current date)
		set {its year, its day, its time} to {1970, 1, 0}
		set its month to 1 -- set after day for fear of Feb :-)
		return (it + (my (time to GMT)))
	end tell
end UnixEpoch

-- Left pad with zeroes to get a fixed digit length
on padnum(lngNum, lngDigits)
	set strNum to lngNum as string
	set lngGap to (lngDigits - (length of strNum))
	repeat while lngGap > 0
		set strNum to "0" & strNum
		set lngGap to lngGap - 1
	end repeat
	return strNum
end padnum

-- 'plugin' ⇄ 'plugins'
on pl(strWord, lng)
	if lng > 1 then
		strWord & "s"
	else
		strWord
	end if
end pl

-- 'need' ⇄ 'needs'
on apl(strWord, lng)
	if lng < 2 then
		strWord & "s"
	else
		strWord
	end if
end apl
