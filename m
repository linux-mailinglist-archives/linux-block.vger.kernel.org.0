Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D2E9099
	for <lists+linux-block@lfdr.de>; Tue, 29 Oct 2019 21:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbfJ2ULd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 29 Oct 2019 16:11:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54678 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJ2ULd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 16:11:33 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 9C1E8283BD1
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-block@vger.kernel.org
Cc:     osandov@fb.com, kernel@collabora.com, krisman@collabora.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH blktests 0/3] Add --config argument for custom config filenames
Date:   Tue, 29 Oct 2019 17:09:39 -0300
Message-Id: <20191029200942.83044-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of just using the default config file, one may also find useful to
specify which configuration file would like to use without editing the config
file, like this:

$ ./check --config=tests_nvme
...
$ ./check -c tests_scsi

This pull request solves this. This change means to be optional, in the sense
that the default behavior should not be modified and current setups will not be
affect by this. To check if this is true, I have done the following test:

- Print the value of variables $DEVICE_ONLY, $QUICK_RUN, $TIMEOUT,
  $RUN_ZONED_TESTS, $OUTPUT, $EXCLUDE
  
- Run with the following setups:
    - with a config file in the dir
    - without a config file in the dir
    - configuring using command line arguments

With both original code and with my changes, I validated that the values
remained the same. Then, I used the argument --config=test_config to check that
the values of variables are indeed changing.

This patchset add this feature, update the docs and fix a minor issue with a
command line argument. Also, I have changed "# shellcheck disable=SC1091" to
"# shellcheck source=/dev/null", since it seems the proper way to disable this
check according to shellcheck documentation[1].

Thanks,
André

[1] https://github.com/koalaman/shellcheck/wiki/SC1090#exceptions

This patch is also avaible at GitHub:
https://github.com/osandov/blktests/pull/56

André Almeida (3):
  check: Add configuration file option
  Documentation: Add information about `--config` argument
  check: Make "device-only" option a valid option

 Documentation/running-tests.md |  3 ++-
 check                          | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 6 deletions(-)

-- 
2.23.0

