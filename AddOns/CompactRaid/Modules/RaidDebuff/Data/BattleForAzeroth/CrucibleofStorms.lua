------------------------------------------------------------
-- CrucibleofStorms.lua
--
-- QK
-- 2019/04/23
------------------------------------------------------------
 local module = CompactRaid:GetModule("RaidDebuff")
 if not module then return end

 
local TIER = 8 
local INSTANCE = 1177 -- �籩��¯ -- CrucibleofStorms
local BOSS 
 
 
BOSS = 2328 -- �����ص� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282384) -- ������� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282566) -- ����Ӧ�� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282743) -- �籩���� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282738) -- ���֮ӵ 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282589) -- ������Ϯ 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 287876) -- �ڰ����� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282432, 6) -- ����֮�� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282621) -- ���ɼ�֤ 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282517) -- �־���� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 282540) -- �������� 

 
BOSS = 2332 -- �����أ�������� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 284851) -- ĩ��֮�� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 285652, 6) -- ̰ʳ��ĥ 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 285345, 6) -- ����˹����֮�� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 285562) -- ����֪�Ŀ־� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 285477) -- Ԩ�� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 285367) -- ����˹�Ĵ������� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 285685) -- ����˹֮�ͣ���� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 284804) -- ��Ԩ���� 
module:RegisterDebuff(TIER, INSTANCE, BOSS, 284733, 6) -- ���֮ӵ 

BOSS = 0 -- Trash
