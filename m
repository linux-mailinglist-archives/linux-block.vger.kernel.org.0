Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC6C563E23
	for <lists+linux-block@lfdr.de>; Sat,  2 Jul 2022 06:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiGBEKO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 2 Jul 2022 00:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbiGBEKL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 Jul 2022 00:10:11 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769C82FE7C
        for <linux-block@vger.kernel.org>; Fri,  1 Jul 2022 21:10:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id d66-20020a636845000000b0040a88edd9c1so2062887pgc.13
        for <linux-block@vger.kernel.org>; Fri, 01 Jul 2022 21:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2l3RLFgAAfB5gJrS1WFhkf1GPwe6iqzG1+pocvCkvn8=;
        b=n85fmgV8YL13NHOXAmDkw3hynV0Gh5QmNiSYsQm9jCdqtwslpAV93ZkYc8QzXG/8ep
         v9U2XDzaCoZBQ8BppCGZehEzLXTSKwGi+Zpi4ojVgQAxgVqVHZXNO0duA3b4gAoTMt80
         +sHwKmRZxha0fJjw+Qztxf8qBWq1NZ/3BSsSp0HINUSML2vIsTS0UIbfMcbG+aeYsgD4
         sPJ6AgB6kCdT7jUGinD6jUuhntlOLxQ0Be12GKo/Ra20XkoVtDN1yGG6N6aadBczZ4dQ
         WsL/dZ1TVlt+6M9D6Oeoci3tRrtxwPx+1Ii+kKcRy9o4ydGTIlLMjK0kgyXLl4CcWRNI
         2q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2l3RLFgAAfB5gJrS1WFhkf1GPwe6iqzG1+pocvCkvn8=;
        b=lHxgQmyuZvH5Kyr6AkP2goW7P7iPd0m1kIeGSJID9Ute+6EFg2Qmc7tfUTI43pQ7ae
         d8NoECnWB/6y4nZNH4ZgrZpqhW1KNN1NEtbiZYjvEnYYa+wiqkaX8WixBhd5ybblhW1/
         f4Qh99XXqNu2/qDFez6V70NKoNRSE0Sjtbp5wO6TESIMMubConlvAPb3Kn31i/ey6TG0
         rbp9X2RVWSqIgFWQAczA7E0TOBwpQ5TFJWAsOH+Ffv7HTq2Pt/UmP5qjmnVB3swBecLI
         k5DDlZkzLTyW+a+z9BxHX2VB/6xoIhhHZkUahD8Fb84OOXJXYHOw89ERVjXWSnMX3fTt
         b3bg==
X-Gm-Message-State: AJIora/YJJYAyHjgsWcK2F0s1PHHN24tySDF4j4oZBBcq0YJpK6yCC3a
        J9QBQqLQqpEpQrC3e4+WmlYtUxXitxUXYQ==
X-Google-Smtp-Source: AGRyM1t57UbR+SZZR/NQAR1HDFq+gH9joW4fT50YArEFanjs2sHJOJuDfSxR47/JHfZFnFLUaBY6Az3aScZMCg==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a17:902:e5cd:b0:16a:6f96:eb9 with SMTP id
 u13-20020a170902e5cd00b0016a6f960eb9mr23833900plf.69.1656735009687; Fri, 01
 Jul 2022 21:10:09 -0700 (PDT)
Date:   Sat,  2 Jul 2022 12:09:57 +0800
In-Reply-To: <20220702040959.3232874-1-davidgow@google.com>
Message-Id: <20220702040959.3232874-2-davidgow@google.com>
Mime-Version: 1.0
References: <20220702040959.3232874-1-davidgow@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v5 2/4] module: panic: Taint the kernel when selftest modules load
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Gow <davidgow@google.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Taint the kernel with TAINT_TEST whenever a test module loads, by adding
a new "TEST" module property, and setting it for all modules in the
tools/testing directory. This property can also be set manually, for
tests which live outside the tools/testing directory with:
MODULE_INFO(test, "Y");

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: David Gow <davidgow@google.com>
---
 kernel/module/main.c  | 7 +++++++
 scripts/mod/modpost.c | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index fed58d30725d..730503561eb0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1988,6 +1988,13 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
 	/* Set up license info based on the info section */
 	set_license(mod, get_modinfo(info, "license"));
 
+	if (!get_modinfo(info, "test")) {
+		if (!test_taint(TAINT_TEST))
+			pr_warn_once("%s: loading test module taints kernel.\n",
+				     mod->name);
+		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
+	}
+
 	return 0;
 }
 
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29d5a841e215..5937212b4433 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2191,6 +2191,9 @@ static void add_header(struct buffer *b, struct module *mod)
 
 	if (strstarts(mod->name, "drivers/staging"))
 		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
+
+	if (strstarts(mod->name, "tools/testing"))
+		buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
 }
 
 static void add_exported_symbols(struct buffer *buf, struct module *mod)
-- 
2.37.0.rc0.161.g10f37bed90-goog

