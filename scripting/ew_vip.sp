#include <vip_core>
#include <k1_easement_weapons>

public Plugin myinfo = 
{
    name = "[EW] VIP",
    author = "K1NG",
    description = "http//projecttm.ru/",
    version = "1.0"
}

public void OnPluginStart()
{	
	if (VIP_IsVIPLoaded()) VIP_OnVIPLoaded();
}

public void VIP_OnVIPLoaded()
{
	VIP_RegisterFeature("ew_immunity", BOOL, HIDE);
    if(K1_EW_IsStarted())
    {
        for(int i = 1; i <= MaxClients; ++i)
        {
            if(IsValidClient(i) && VIP_IsClientVIP(i) && VIP_IsClientFeatureUse(i, "ew_immunity"))
                K1_EW_GiveImmunity(i);
        }
    }
}

public void K1_EW_Started()
{
	char sBuffer[512];
	for (int iClient = 1; iClient <= MaxClients; iClient++)
	{
		if (IsValidClient(iClient) && VIP_IsClientFeatureUse(iClient, "ew_immunity"))
		{
			K1_EW_GiveImmunity(iClient);
		}
	}
}

public void OnPluginEnd()
{
	VIP_UnregisterFeature("ew_immunity");
}

public void VIP_OnVIPClientLoaded(int iClient)
{
	if(K1_EW_IsStarted() && VIP_IsClientFeatureUse(iClient, "ew_immunity"))
		K1_EW_GiveImmunity(iClient);
}

bool IsValidClient(int iClient)
{
	if (!(1 <= iClient <= MaxClients) || !IsClientInGame(iClient) || IsFakeClient(iClient) || IsClientSourceTV(iClient) || IsClientReplay(iClient))
	{
		return false;
	}
	return true;
}