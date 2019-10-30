Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CBEA628
	for <lists+linux-block@lfdr.de>; Wed, 30 Oct 2019 23:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfJ3W2k (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 30 Oct 2019 18:28:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39730 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfJ3W2k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Oct 2019 18:28:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 29E3F28F109
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH blktests v2 1/3] check: Make "device-only" option a valid option
Date:   Wed, 30 Oct 2019 19:27:05 -0300
Message-Id: <20191030222707.10142-2-andrealmeid@collabora.com>
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

"--device-only" option is described at the "Usage" help message and it's
even parsed as an option by the main code. However, since it's not a
parameter of getopt, when trying to use it will trigger a "unrecognized
option". Fix that to allow usage of this option.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index 981058c..a19b9dc 100755
--- a/check
+++ b/check
@@ -650,7 +650,7 @@ Miscellaneous:
 	esac
 }
 
-if ! TEMP=$(getopt -o 'do:q::x:h' --long 'quick::,exclude:,output:,help' -n "$0" -- "$@"); then
+if ! TEMP=$(getopt -o 'do:q::x:h' --long 'device-only,quick::,exclude:,output:,help' -n "$0" -- "$@"); then
 	exit 1
 fi
 
-- 
2.23.0

