Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31C02AB665
	for <lists+linux-block@lfdr.de>; Mon,  9 Nov 2020 12:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKILRi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 9 Nov 2020 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbgKILRh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 06:17:37 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB5CC0613D6
        for <linux-block@vger.kernel.org>; Mon,  9 Nov 2020 03:17:37 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id c20so7848787pfr.8
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2020 03:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=M29EFKGcsccLBMFCXJrq4LHYnBqYH4hfEsrCaRgmoeY=;
        b=g4B9SkJbx65UXGB78bcBHPLyKlEhwT2V7Ev8iQ5CC2BwyMPJa+HGdq6PTs8yPoLVBO
         +WWjQ9uUx3V56pumdhuXyRf4BB1G3Hg8RIarxWjZs3ESc2f2N5z8Kx5rusT85BhVpo6l
         33Z+J/muUq+j38DYZsBQ1Q/wnLHFfBR7LLGwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=M29EFKGcsccLBMFCXJrq4LHYnBqYH4hfEsrCaRgmoeY=;
        b=NkCGARQAr5WDOB9l8tZG+Y/AZLzWB6lW7SLXuqhFlIOtu7tNSkBgccGB/al1mRYM+z
         jFvYJvrLAzy0OAikwXblcAagOO73yJsk64gI1SDIxc5HnHFUYpheVpyth2Uf8saxrIc7
         NhZS4WFUMvuarN9NPUENf13RYz86EagdjrCXQG2AEoaalzMv89Y73paY6xPtPLSezdok
         IlMH3ef2loah0525zWLEBFw62ccr2ZJEAnZWtCDPRtZS/wWq+OKQlqVZnr3vqYy2/Aie
         QK4afzdWF3vItzjEmxBEd4TDhc/HXPpztDFyXRQUsrnvNMifHLdgfq5b0ltfKZONIPdM
         yfsg==
X-Gm-Message-State: AOAM5319nuOdycEUZIpvcwDO/bcfxOc/mCC7LF3oDLVm8aXnMggWzeep
        HbErFZrN4T/P94kzSPuDORSCdoC6GqvThUrqrTNAGVZM4wkhhFy2LtrzHeoZIGMIAKGxjmyZAmu
        TlsiN4aW5A0OLCD/xG9wsusD7MME97WAHVwohN6HUkEy4QwdpZi6utXpm1d9ud0av2ZuZqiNO2Y
        y9sms/9t2ceeZ6
X-Google-Smtp-Source: ABdhPJyh8DAg928IME1ogv9LTLGXxn4yHsy7/H6DeZqyEP9xtrtkiFNcJ1eANkB6APS0p2tc2IinHA==
X-Received: by 2002:a17:90b:1881:: with SMTP id mn1mr12942490pjb.225.1604920656785;
        Mon, 09 Nov 2020 03:17:36 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k9sm10889364pfp.68.2020.11.09.03.17.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:17:36 -0800 (PST)
From:   Muneendra <muneendra.kumar@broadcom.com>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        tj@kernel.org, linux-nvme@lists.infradead.org
Cc:     jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
        pbonzini@redhat.com, Muneendra <muneendra.kumar@broadcom.com>
Subject: [PATCH v4 03/19] nvme: Added a newsysfs attribute appid_store
Date:   Mon,  9 Nov 2020 09:53:49 +0530
Message-Id: <1604895845-2587-4-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a9024105b3aab520"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--000000000000a9024105b3aab520

Added a new sysfs attribute appid_store under
/sys/class/fc/fc_udev_device/*

With this new interface the user can set the application identfier
in  the blkcg associted with cgroup id.

Once the application identifer has set with this interface it allows
identification of traffic sources at an individual cgroup based
Applications (ex:virtual machine (VM))level in both host and
fabric infrastructure(FC).

Below is the interface provided to set the app_id

echo "<cgroupid>:<appid>" >> /sys/class/fc/fc_udev_device/appid_store
echo "457E:100000109b521d27" >> /sys/class/fc/fc_udev_device/appid_store

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>

---
v4:
No change

v3:
Replaced blkcg_set_app_identifier function with blkcg_set_fc_appid

v2:
New Patch
---
 drivers/nvme/host/fc.c | 73 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index eae43bb444e0..6d6cc06fd54a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -9,7 +9,7 @@
 #include <uapi/scsi/fc/fc_els.h>
 #include <linux/delay.h>
 #include <linux/overflow.h>
-
+#include <linux/blk-cgroup.h>
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-fc-driver.h>
@@ -3768,10 +3768,81 @@ static ssize_t nvme_fc_nvme_discovery_store(struct device *dev,
 
 	return count;
 }
+
+/*parse the Cgroup id from a buf and returns the length of cgrpid*/
+static int fc_parse_cgrpid(const char *buf, u64 *id)
+{
+	char cgrp_id[16+1];
+	int cgrpid_len, j;
+
+	memset(cgrp_id, 0x0, sizeof(cgrp_id));
+	for (cgrpid_len = 0, j = 0; cgrpid_len < 17; cgrpid_len++) {
+		if (buf[cgrpid_len] != ':')
+			cgrp_id[cgrpid_len] = buf[cgrpid_len];
+		else {
+			j = 1;
+			break;
+		}
+	}
+	if (!j)
+		return -EINVAL;
+	if (kstrtou64(cgrp_id, 16, id) < 0)
+		return -EINVAL;
+	return cgrpid_len;
+}
+
+/*
+ * fc_update_appid :parses and updates the appid in the blkcg associated with
+ * cgroupid.
+ * @buf: buf contains both cgrpid and appid info
+ * @count: size of the buffer
+ */
+static int fc_update_appid(const char *buf, size_t count)
+{
+	u64 cgrp_id;
+	int appid_len = 0;
+	int cgrpid_len = 0;
+	char app_id[APPID_LEN];
+	int ret = 0;
+
+	if (buf[count-1] == '\n')
+		count--;
+
+	if ((count > (16+1+APPID_LEN)) || (!strchr(buf, ':')))
+		return -EINVAL;
+
+	cgrpid_len = fc_parse_cgrpid(buf, &cgrp_id);
+	if (cgrpid_len < 0)
+		return -EINVAL;
+	/*appid len is count - cgrpid_len -1 (: + \n) */
+	appid_len = count - cgrpid_len - 1;
+	if (appid_len > APPID_LEN)
+		return -EINVAL;
+
+	memset(app_id, 0x0, sizeof(app_id));
+	memcpy(app_id, &buf[cgrpid_len+1], appid_len);
+	ret = blkcg_set_app_identifier(app_id, cgrp_id, sizeof(app_id));
+	if (ret < 0)
+		return ret;
+	return count;
+}
+
+static ssize_t fc_appid_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	int ret  = 0;
+
+	ret = fc_update_appid(buf, count);
+	if (ret < 0)
+		return -EINVAL;
+	return count;
+}
 static DEVICE_ATTR(nvme_discovery, 0200, NULL, nvme_fc_nvme_discovery_store);
+static DEVICE_ATTR(appid_store, 0200, NULL, fc_appid_store);
 
 static struct attribute *nvme_fc_attrs[] = {
 	&dev_attr_nvme_discovery.attr,
+	&dev_attr_appid_store.attr,
 	NULL
 };
 
-- 
2.26.2


--000000000000a9024105b3aab520
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
BCDYlnSuxagtAmbij3+PI2GGFaPs2ASvkPewiIbbdUXPUTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMDkxMTE3MzdaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAHXhxukQr0+LwtlHt
ym+EW6qrn9u6yrPOMR6mzus1rxFopmTxQacBb+KKXjSIuwWFGbd47TMFn4OIsXAb+8iXXMtFQcrM
dldQPCkRD26f+TdXJhw3ZQMV53+l86MqJMqoEiu9H2EuMB/+EJzshM01UO4HyV1uaoHYpAIZ7ndz
868ULmHT+tZaelcKB8NSJLmMvrRwVDJ6R9O0bGnElvEGjuYq5T5NGiJ2LuOapLh14UlqfN7qKxtv
g0zHLNn1TbEMiCqZZAtVnpn0sl/cOpw7ErgYa5SKQwGlLidSRfv2Vg6hFLOKmnWpKqkVI0Lgj0cg
dxyOuKt6YjPcrneDNADPgA==
--000000000000a9024105b3aab520--
