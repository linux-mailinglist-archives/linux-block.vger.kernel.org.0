Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 121D629296F
	for <lists+linux-block@lfdr.de>; Mon, 19 Oct 2020 16:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgJSOgq (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 19 Oct 2020 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbgJSOgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 10:36:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCF9C0613D0
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 07:36:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id lw2so1183555pjb.3
        for <linux-block@vger.kernel.org>; Mon, 19 Oct 2020 07:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GcRLTDmjAyLkoQJ+bnXLHGOaJNVZcDv44dO+ZlqsAhM=;
        b=C4Zz3tL1htpAw0t5R2HCwPSMb0zA1OXQB8XyMPaJmUZMKGrc6g+rpRspER6dA7Hood
         0bYxezvXoAi5qyYrz4uj0awUUYLCepIlqn1zZhqR6R0wgwgY5scUY/TjtPW9O+xhx38h
         v1Ke/itrX62wSs2jjzhQFgsF4jtQ9Gi2HbuKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GcRLTDmjAyLkoQJ+bnXLHGOaJNVZcDv44dO+ZlqsAhM=;
        b=mokPYEvLz8u/sok1Bzd3PoaLnjtoZnvgTHKKuYLFLDujcfgKW8qqQgjKftQRnmAkcr
         eXPVLQD//bh7ds3scHyWwD/Kx+1ri7WsRX9KbQC4ITVo8YTMSc5V9yOxO2cdwprgUSG6
         ZIrb9OIxV0+10SrXUvO9pQz2WRC4vXbLFHYG7x5fhUb6D1swXUcpTrnYUT2dVzJ2Nc08
         jA0pje2aIatIPJ2yIbRw3GJ99t8Z1qyfRd2uq3IebTq3HfBe2X+PUGhk0Blze9iCZyjA
         saL3zLAWsP04N6ypR8N/eHQnP1RKUuWA8pKlu9gBMHflix6viRb92BCUWzSJO6N7A7QR
         gK5A==
X-Gm-Message-State: AOAM5316y5LYIYUOfxOl/APvCEv8aOATT4R8MkIOXUHc70p5TZT3EX23
        N2wC6pzMB0prNrZYlkO5WdxrEPBWdTWM3e9HMDtWgnyuGhQj+vWHJU3gagWEVAoCLGWww4t/3jE
        Ki+eEkecxCqFZTr7DlkWg0zSdKaXqdY1ubQfEp+SmiwBH2VDu6Z24xQZT6yhJzlNqRSYeD0mqLw
        jT2FRwduIC/uPW
X-Google-Smtp-Source: ABdhPJxJTHTWuBPPKZfRmbNisYnsTQhfguxC9/ZUkbp3EwnAfwfRjg4TM+UBtI1hYJks2iLdlGaB8w==
X-Received: by 2002:a17:90a:4b4e:: with SMTP id o14mr90782pjl.216.1603118205179;
        Mon, 19 Oct 2020 07:36:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id kb15sm53377pjb.17.2020.10.19.07.36.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 07:36:44 -0700 (PDT)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        pbonzini@redhat.com, Muneendra <muneendra.kumar@broadcom.com>
Subject: [RFC v2 01/18] cgroup: Added cgroup_get_from_kernfs_id
Date:   Mon, 19 Oct 2020 13:12:56 +0530
Message-Id: <1603093393-12875-2-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002ccc2e05b2070b46"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000002ccc2e05b2070b46

Added a new function cgroup_get_from_kernfs_id  to retrieve the cgroup
associated with cgroup id.
It takes cgroupid as an argument and returns cgrp and on failure
it returns NULL.
Exported the same as this can be used by blk-cgorup.c

Added function declaration of cgroup_get_from_kernfs_id in cgorup.h

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v2:
New patch
---
 include/linux/cgroup.h |  6 ++++++
 kernel/cgroup/cgroup.c | 25 +++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 618838c48313..1741f02a41d6 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -696,6 +696,7 @@ static inline void cgroup_kthread_ready(void)
 }
 
 void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen);
+struct cgroup *cgroup_get_from_kernfs_id(u64 id);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -743,6 +744,11 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 
 static inline void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 {}
+
+static struct cgroup *cgroup_get_from_kernfs_id(u64 id)
+{
+	return NULL;
+}
 #endif /* !CONFIG_CGROUPS */
 
 #ifdef CONFIG_CGROUPS
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index dd247747ec14..f34ca94b04c0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5803,6 +5803,31 @@ void cgroup_path_from_kernfs_id(u64 id, char *buf, size_t buflen)
 	kernfs_put(kn);
 }
 
+/*
+ * cgroup_get_from_kernfs_id : get the cgroup associated with cgroup id
+ * @id: cgroup id
+ * On success it returns the cgrp on failure it returns NULL
+ */
+struct cgroup *cgroup_get_from_kernfs_id(u64 id)
+{
+	struct kernfs_node *kn;
+	struct cgroup *cgrp = NULL;
+
+	mutex_lock(&cgroup_mutex);
+	kn = kernfs_find_and_get_node_by_id(cgrp_dfl_root.kf_root, id);
+	if (!kn)
+		goto out_unlock;
+
+	cgrp = kn->priv;
+	if (cgroup_is_dead(cgrp) || !cgroup_tryget(cgrp))
+		cgrp = NULL;
+	kernfs_put(kn);
+out_unlock:
+	mutex_unlock(&cgroup_mutex);
+	return cgrp;
+}
+EXPORT_SYMBOL_GPL(cgroup_get_from_kernfs_id);
+
 /*
  * proc_cgroup_show()
  *  - Print task's cgroup paths into seq_file, one line for each hierarchy
-- 
2.26.2


--0000000000002ccc2e05b2070b46
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCAXhObmJACsAb8RI4a/Tz/hk1u4CyXZsbpeaBZpoU4LzTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEwMTkxNDM2NDVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEArySwj6HKftRqWS7L
o+F3ylGADSWwL3raGAOsd6gqH3LNYVYOoYVCJapjNuudgXaCIaeJsbRkKrCAg80HgwIbtwKItXZ0
QTST9mCYSsNOaaF+dnfhhAqDDlAPVDcznzrjpGJB+nsbp7MKczEx6KwLxZdYLgbNKHRLR+Gw64WM
ZzMt3HbyLKtH2orLWNYtD1A2FaGFdXx1x+jCGk0e0omLIrWq3q5F11s4/Fqj7mQVs2HcPkXOnZhr
++tWKYjEqWNmRKW//HxEiOITRm+vvJaOeXgFi8S2f7geUA100KYOkmpWDkET1F/pmmGJhBOmQddW
rpuE3OFIxNv6ALcOV1AURw==
--0000000000002ccc2e05b2070b46--
