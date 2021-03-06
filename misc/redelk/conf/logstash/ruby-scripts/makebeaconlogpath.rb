#
# Part of RedELK
# Script to have logstash insert an extra field pointing to the full TXT file of a Cobalt Strike keystrokes file
#
# Author: Outflank B.V. / Marc Smeets / @mramsmeets
#
# License : BSD3
#



def register(params)
#        @timestamp = params["timestamp"]
#        @source = param["source"]
#	@beacon_id = param["beacon_id"]
end

def filter(event)
    host = event.get("[agent][name]")
    scenario = event.get("attackscenario")
    logpath = event.get("[log][file][path]")
	beacon_id = event.get("beacon_id")
	temppath = logpath.split('/cobaltstrike')
	temppath2 = temppath[1].split(/\/([^\/]*)$/)
	beaconlogpath = "/cslogs/" + "#{scenario}" + "/" + "#{host}" + "#{temppath[1]}"
	event.tag("_rubyparseok")
    	event.set("beaconlogfile", beaconlogpath)
	return [event]
end
