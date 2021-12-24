
addon.name      = 'extexec';
addon.author    = 'arosecra';
addon.version   = '1.0';
addon.desc      = 'Performs text replacement before executing a command';
addon.link      = 'TBD';

local common = require('common');

ashita.events.register('command', 'command_callback1', function (e)
	if (not e.command:startswith('/extexec')) then
        return
    end
    e.blocked = true;
	
	local args = e.command:argsquoted()

    local memoryManager = AshitaCore:GetMemoryManager();
	local party = memoryManager:GetParty();
	local mainjob = AshitaCore:GetResourceManager():GetString("jobs.names_abbr", party:GetMemberMainJob(0));
	
	local values = {
		['NAME'] = party:GetMemberName(0),
		['MAINJOB'] = mainjob
	};
	
	local command = string.gsub(args[2], "%$(%w+)", values);
	AshitaCore:GetChatManager():QueueCommand(1, "/exec " .. command);
	
end);