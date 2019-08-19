Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B894FF0
	for <lists+linux-block@lfdr.de>; Mon, 19 Aug 2019 23:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfHSVdU (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Aug 2019 17:33:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:53841 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728351AbfHSVdU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 17:33:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 14:33:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,406,1559545200"; 
   d="scan'208";a="377562883"
Received: from unknown (HELO revanth-X299-AORUS-Gaming-3-Pro.lm.intel.com) ([10.232.116.91])
  by fmsmga005.fm.intel.com with ESMTP; 19 Aug 2019 14:33:19 -0700
From:   Revanth Rajashekar <revanth.rajashekar@intel.com>
To:     <linux-block@vger.kernel.org>
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <sbauer@plzdonthack.me>,
        Revanth Rajashekar <revanth.rajashekar@intel.com>
Subject: [PATCH v2 1/3] block: sed-opal: Add/remove spaces
Date:   Mon, 19 Aug 2019 15:35:04 -0600
Message-Id: <20190819213506.14788-2-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819213506.14788-1-revanth.rajashekar@intel.com>
References: <20190819213506.14788-1-revanth.rajashekar@intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 block/opal_proto.h |  3 +--
 block/sed-opal.c   | 45 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/block/opal_proto.h b/block/opal_proto.h
index 466ec7be16ef..562b78f40824 100644
--- a/block/opal_proto.h
+++ b/block/opal_proto.h
@@ -167,7 +167,6 @@ enum opal_token {
 	OPAL_TABLE_LASTID = 0x0A,
 	OPAL_TABLE_MIN = 0x0B,
 	OPAL_TABLE_MAX = 0x0C,
-
 	/* authority table */
 	OPAL_PIN = 0x03,
 	/* locking tokens */
@@ -182,7 +181,7 @@ enum opal_token {
 	OPAL_LIFECYCLE = 0x06,
 	/* locking info table */
 	OPAL_MAXRANGES = 0x04,
-	 /* mbr control */
+	/* mbr control */
 	OPAL_MBRENABLE = 0x01,
 	OPAL_MBRDONE = 0x02,
 	/* properties */
diff --git a/block/sed-opal.c b/block/sed-opal.c
index 7e1a444a25b2..d442f29e84f1 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -129,7 +129,6 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 		{ 0x00, 0x00, 0x00, 0x09, 0x00, 0x00, 0x84, 0x01 },

 	/* tables */
-
 	[OPAL_TABLE_TABLE]
 		{ 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01 },
 	[OPAL_LOCKINGRANGE_GLOBAL] =
@@ -152,7 +151,6 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 		{ 0x00, 0x00, 0x08, 0x01, 0x00, 0x00, 0x00, 0x00 },

 	/* C_PIN_TABLE object ID's */
-
 	[OPAL_C_PIN_MSID] =
 		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x00, 0x84, 0x02},
 	[OPAL_C_PIN_SID] =
@@ -161,7 +159,6 @@ static const u8 opaluid[][OPAL_UID_LENGTH] = {
 		{ 0x00, 0x00, 0x00, 0x0B, 0x00, 0x01, 0x00, 0x01},

 	/* half UID's (only first 4 bytes used) */
-
 	[OPAL_HALF_UID_AUTHORITY_OBJ_REF] =
 		{ 0x00, 0x00, 0x0C, 0x05, 0xff, 0xff, 0xff, 0xff },
 	[OPAL_HALF_UID_BOOLEAN_ACE] =
@@ -517,6 +514,7 @@ static int opal_discovery0(struct opal_dev *dev, void *data)
 	ret = opal_recv_cmd(dev);
 	if (ret)
 		return ret;
+
 	return opal_discovery0_end(dev);
 }

@@ -525,6 +523,7 @@ static int opal_discovery0_step(struct opal_dev *dev)
 	const struct opal_step discovery0_step = {
 		opal_discovery0,
 	};
+
 	return execute_step(dev, &discovery0_step, 0);
 }

@@ -551,6 +550,7 @@ static void add_token_u8(int *err, struct opal_dev *cmd, u8 tok)
 {
 	if (!can_add(err, cmd, 1))
 		return;
+
 	cmd->cmd[cmd->pos++] = tok;
 }

@@ -577,6 +577,7 @@ static void add_medium_atom_header(struct opal_dev *cmd, bool bytestring,
 	header0 |= bytestring ? MEDIUM_ATOM_BYTESTRING : 0;
 	header0 |= has_sign ? MEDIUM_ATOM_SIGNED : 0;
 	header0 |= (len >> 8) & MEDIUM_ATOM_LEN_MASK;
+
 	cmd->cmd[cmd->pos++] = header0;
 	cmd->cmd[cmd->pos++] = len;
 }
@@ -649,6 +650,7 @@ static int build_locking_range(u8 *buffer, size_t length, u8 lr)

 	if (lr == 0)
 		return 0;
+
 	buffer[5] = LOCKING_RANGE_NON_GLOBAL;
 	buffer[7] = lr;

@@ -945,6 +947,7 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 	}

 	*store = tok->pos + skip;
+
 	return tok->len - skip;
 }

@@ -1062,6 +1065,7 @@ static int start_opal_session_cont(struct opal_dev *dev)

 	dev->hsn = hsn;
 	dev->tsn = tsn;
+
 	return 0;
 }

@@ -1084,6 +1088,7 @@ static int end_session_cont(struct opal_dev *dev)
 {
 	dev->hsn = 0;
 	dev->tsn = 0;
+
 	return parse_and_check_status(dev);
 }

@@ -1172,6 +1177,7 @@ static int gen_key(struct opal_dev *dev, void *data)
 		return err;

 	}
+
 	return finalize_and_send(dev, parse_and_check_status);
 }

@@ -1184,12 +1190,14 @@ static int get_active_key_cont(struct opal_dev *dev)
 	error = parse_and_check_status(dev);
 	if (error)
 		return error;
+
 	keylen = response_get_string(&dev->parsed, 4, &activekey);
 	if (!activekey) {
 		pr_debug("%s: Couldn't extract the Activekey from the response\n",
 			 __func__);
 		return OPAL_INVAL_PARAM;
 	}
+
 	dev->prev_data = kmemdup(activekey, keylen, GFP_KERNEL);

 	if (!dev->prev_data)
@@ -1251,6 +1259,7 @@ static int generic_lr_enable_disable(struct opal_dev *dev,

 	add_token_u8(&err, dev, OPAL_ENDLIST);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
+
 	return err;
 }

@@ -1263,6 +1272,7 @@ static inline int enable_global_lr(struct opal_dev *dev, u8 *uid,
 					0, 0);
 	if (err)
 		pr_debug("Failed to create enable global lr command\n");
+
 	return err;
 }

@@ -1313,7 +1323,6 @@ static int setup_locking_range(struct opal_dev *dev, void *data)
 	if (err) {
 		pr_debug("Error building Setup Locking range command.\n");
 		return err;
-
 	}

 	return finalize_and_send(dev, parse_and_check_status);
@@ -1393,6 +1402,7 @@ static int start_SIDASP_opal_session(struct opal_dev *dev, void *data)
 		kfree(key);
 		dev->prev_data = NULL;
 	}
+
 	return ret;
 }

@@ -1518,6 +1528,7 @@ static int erase_locking_range(struct opal_dev *dev, void *data)
 		pr_debug("Error building Erase Locking Range Command.\n");
 		return err;
 	}
+
 	return finalize_and_send(dev, parse_and_check_status);
 }

@@ -1636,6 +1647,7 @@ static int write_shadow_mbr(struct opal_dev *dev, void *data)

 		off += len;
 	}
+
 	return err;
 }

@@ -1816,6 +1828,7 @@ static int lock_unlock_locking_range(struct opal_dev *dev, void *data)
 		pr_debug("Error building SET command.\n");
 		return err;
 	}
+
 	return finalize_and_send(dev, parse_and_check_status);
 }

@@ -1857,6 +1870,7 @@ static int lock_unlock_locking_range_sum(struct opal_dev *dev, void *data)
 		pr_debug("Error building SET command.\n");
 		return ret;
 	}
+
 	return finalize_and_send(dev, parse_and_check_status);
 }

@@ -1957,6 +1971,7 @@ static int end_opal_session(struct opal_dev *dev, void *data)

 	if (err < 0)
 		return err;
+
 	return finalize_and_send(dev, end_session_cont);
 }

@@ -1965,6 +1980,7 @@ static int end_opal_session_error(struct opal_dev *dev)
 	const struct opal_step error_end_session = {
 		end_opal_session,
 	};
+
 	return execute_step(dev, &error_end_session, 0);
 }

@@ -1984,6 +2000,7 @@ static int check_opal_support(struct opal_dev *dev)
 	ret = opal_discovery0_step(dev);
 	dev->supported = !ret;
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2004,6 +2021,7 @@ void free_opal_dev(struct opal_dev *dev)
 {
 	if (!dev)
 		return;
+
 	clean_opal_dev(dev);
 	kfree(dev);
 }
@@ -2026,6 +2044,7 @@ struct opal_dev *init_opal_dev(void *data, sec_send_recv *send_recv)
 		kfree(dev);
 		return NULL;
 	}
+
 	return dev;
 }
 EXPORT_SYMBOL(init_opal_dev);
@@ -2045,6 +2064,7 @@ static int opal_secure_erase_locking_range(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2062,6 +2082,7 @@ static int opal_erase_locking_range(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, erase_steps, ARRAY_SIZE(erase_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2089,6 +2110,7 @@ static int opal_enable_disable_shadow_mbr(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2113,6 +2135,7 @@ static int opal_set_mbr_done(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2133,6 +2156,7 @@ static int opal_write_shadow_mbr(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, mbr_steps, ARRAY_SIZE(mbr_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2151,6 +2175,7 @@ static int opal_save(struct opal_dev *dev, struct opal_lock_unlock *lk_unlk)
 	setup_opal_dev(dev);
 	add_suspend_info(dev, suspend);
 	mutex_unlock(&dev->dev_lock);
+
 	return 0;
 }

@@ -2169,12 +2194,14 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 		pr_debug("Locking state was not RO or RW\n");
 		return -EINVAL;
 	}
+
 	if (lk_unlk->session.who < OPAL_USER1 ||
 	    lk_unlk->session.who > OPAL_USER9) {
 		pr_debug("Authority was not within the range of users: %d\n",
 			 lk_unlk->session.who);
 		return -EINVAL;
 	}
+
 	if (lk_unlk->session.sum) {
 		pr_debug("%s not supported in sum. Use setup locking range\n",
 			 __func__);
@@ -2185,6 +2212,7 @@ static int opal_add_user_to_lr(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, steps, ARRAY_SIZE(steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2267,6 +2295,7 @@ static int opal_lock_unlock(struct opal_dev *dev,
 	mutex_lock(&dev->dev_lock);
 	ret = __opal_lock_unlock(dev, lk_unlk);
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2289,6 +2318,7 @@ static int opal_take_ownership(struct opal_dev *dev, struct opal_key *opal)
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, owner_steps, ARRAY_SIZE(owner_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2310,6 +2340,7 @@ static int opal_activate_lsp(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, active_steps, ARRAY_SIZE(active_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2327,6 +2358,7 @@ static int opal_setup_locking_range(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, lr_steps, ARRAY_SIZE(lr_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2347,6 +2379,7 @@ static int opal_set_new_pw(struct opal_dev *dev, struct opal_new_pw *opal_pw)
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2371,6 +2404,7 @@ static int opal_activate_user(struct opal_dev *dev,
 	setup_opal_dev(dev);
 	ret = execute_steps(dev, act_steps, ARRAY_SIZE(act_steps));
 	mutex_unlock(&dev->dev_lock);
+
 	return ret;
 }

@@ -2382,6 +2416,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)

 	if (!dev)
 		return false;
+
 	if (!dev->supported)
 		return false;

@@ -2399,6 +2434,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 				 suspend->unlk.session.sum);
 			was_failure = true;
 		}
+
 		if (dev->mbr_enabled) {
 			ret = __opal_set_mbr_done(dev, &suspend->unlk.session.opal_key);
 			if (ret)
@@ -2406,6 +2442,7 @@ bool opal_unlock_from_suspend(struct opal_dev *dev)
 		}
 	}
 	mutex_unlock(&dev->dev_lock);
+
 	return was_failure;
 }
 EXPORT_SYMBOL(opal_unlock_from_suspend);
--
2.17.1

