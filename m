Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DB8EA629
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2019 23:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfJ3W2n (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Oct 2019 18:28:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39732 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3W2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 18:28:42 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9D59C28F108
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH blktests v2 2/3] check: Add configuration file option
Date:   Wed, 30 Oct 2019 19:27:06 -0300
Message-Id: <20191030222707.10142-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030222707.10142-1-andrealmeid@collabora.com>
References: <20191030222707.10142-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add an option to be possible to use a different configuration file
rather than the default "config" file.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 check | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/check b/check
index a19b9dc..97a3c97 100755
--- a/check
+++ b/check
@@ -635,6 +635,10 @@ Test runs:
   -x, --exclude=TEST	 exclude a test (or test group) from the list of
 			 tests to run
 
+  -c, --config=FILE	 use FILE for loading configuration instead of
+			 default 'config' filename. Note that, for multiple
+			 uses of this option, all files will be loaded.
+
 Miscellaneous:
   -h, --help             display this help message and exit"
 
@@ -650,7 +654,7 @@ Miscellaneous:
 	esac
 }
 
-if ! TEMP=$(getopt -o 'do:q::x:h' --long 'device-only,quick::,exclude:,output:,help' -n "$0" -- "$@"); then
+if ! TEMP=$(getopt -o 'do:q::x:c:h' --long 'device-only,quick::,exclude:,output:,config:,help' -n "$0" -- "$@"); then
 	exit 1
 fi
 
@@ -659,10 +663,8 @@ unset TEMP
 
 LOGGER_PROG="$(type -P logger)" || LOGGER_PROG=true
 
-if [[ -r config ]]; then
-	# shellcheck disable=SC1091
-	. config
-fi
+# true if the default configuration file "config" should be used
+DEFAULT_CONFIG=true
 
 # Default configuration.
 : "${DEVICE_ONLY:=0}"
@@ -706,6 +708,17 @@ while true; do
 			EXCLUDE+=("$2")
 			shift 2
 			;;
+		'-c'|'--config')
+			if [[ -r "$2" ]]; then
+				# shellcheck source=/dev/null
+				. "$2"
+				DEFAULT_CONFIG=false
+			else
+				echo "Configuration file $2 not found!"
+				usage err
+			fi
+			shift 2
+			;;
 		'-h'|'--help')
 			usage out
 			;;
@@ -719,6 +732,12 @@ while true; do
 	esac
 done
 
+# if '-c' was not used, try to use the default config file
+if [[ -r config ]] && $DEFAULT_CONFIG; then
+	# shellcheck source=/dev/null
+	. config
+fi
+
 if [[ $QUICK_RUN -ne 0 && ! "${TIMEOUT:-}" ]]; then
 	_error "QUICK_RUN specified without TIMEOUT"
 fi
-- 
2.23.0

