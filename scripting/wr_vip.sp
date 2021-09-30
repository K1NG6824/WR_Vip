#include <vip_core>
#include <k1_weapon_reduce>

public Plugin myinfo = 
{
    name = "[WR] VIP",
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
	VIP_RegisterFeature("wr_immunity", BOOL, HIDE);
    if(K1_WR_IsStarted())
    {
        for(int i = 1; i <= MaxClients; ++i)
        {
            if(IsValidClient(i) && VIP_IsClientVIP(i) && VIP_IsClientFeatureUse(i, "wr_immunity"))
                K1_WR_GiveImmunity(i);
        }
    }
}

public void K1_WR_Started()
{
	for (int iClient = 1; iClient <= MaxClients; iClient++)
	{
		if (IsValidClient(iClient) && VIP_IsClientFeatureUse(iClient, "wr_immunity"))
		{
			K1_WR_GiveImmunity(iClient);
		}
	}
}

public void OnPluginEnd()
{
	VIP_UnregisterFeature("wr_immunity");
}

public void VIP_OnVIPClientLoaded(int iClient)
{
	if(K1_WR_IsStarted() && VIP_IsClientFeatureUse(iClient, "wr_immunity"))
		K1_WR_GiveImmunity(iClient);
}

public void VIP_OnVIPClientRemoved(int iClient, const char[] szReason, int iAdmin)
{
	if(K1_WR_IsStarted() && K1_WR_TakeImmunity(iClient) && !K1_WR_CheckImmunity(iClient))
		K1_WR_DropWeapon(iClient);
}

bool IsValidClient(int iClient)
{
	if (!(1 <= iClient <= MaxClients) || !IsClientInGame(iClient) || IsFakeClient(iClient) || IsClientSourceTV(iClient) || IsClientReplay(iClient))
	{
		return false;
	}
	return true;
}