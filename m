Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6170D4F810
	for <lists+linux-block@lfdr.de>; Sat, 22 Jun 2019 21:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfFVTiv (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Sat, 22 Jun 2019 15:38:51 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:40167 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVTiv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Jun 2019 15:38:51 -0400
Received: by mail-wr1-f51.google.com with SMTP id p11so9705476wre.7
        for <linux-block@vger.kernel.org>; Sat, 22 Jun 2019 12:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANjjY8Rh0UaBi+L+QlwWhKYsKX4sBFreV6BGed2sdaU=;
        b=xxdConYxKchtiLYDpULGAnYoE5TK4G4PboR7+Ad8BFltYnf5fKPG4ysWyaqQ53nVO+
         jOzgAyBMqQC+juY/uHlrBd00jUe1vDjQ0aCuWmE2rUsjS39j3ia+0mVSrHTUa6mVo/rc
         ViE3Zm5meCnt61DXudthAcjdAL1hsMmyogC1hbdJXy+KJxI2RKkAMbL5KZ8zZF0fc8PQ
         L6LHP8e/h5RMnR8Y2DrTJnZCzUuoUme1kTnCud7Tubp61L2CgtmawLvwJSxPAn9VKhSe
         9/R8zZusXA1hZeFQTOSdb6LVn8DzaTjm0P4/qko13DHYfu2apHI78VasQwYxp8l8+kPf
         8cvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANjjY8Rh0UaBi+L+QlwWhKYsKX4sBFreV6BGed2sdaU=;
        b=l+WwhsoM8XFKU2nPSqH9qr4yJ0R1RUQOmKxFg8hCTrgAsluLbOWUxIZHkYWl+vzfUd
         ACFh2b8gIJ1cxEnHlabkVR/HeqHVwcTrMB+Zh9YBoS6dugZtvZNMmG3ogAslLmq+HxQv
         /omgGLeasGN0At++hR77ZRz4PkmRCzxyrfcbrHGwnFZtqC0oMN1/p9VtANHY+NrQqdH5
         8aPd6Xga9EpPkEfMfPDHCfcF0J/SjMT8xPFN1m+wdIN5Hnf8drRTf+/Tpf8CYC+i9pSW
         EZ0zCxHeT0mjroaYHR8G7WmUYETK8OSFLuJg4Eqwp5+SvnKdiu5In1DiA0lOpgoX/0HK
         5BjQ==
X-Gm-Message-State: APjAAAUsANWHo4XEBk0fj9/st+/suG6fDRw3tGH1vsPUqlTOz8kQLyt5
        dmXFTpzyOr1rms4hhFrcmNsnyoQ+Usk=
X-Google-Smtp-Source: APXvYqwDeDcUMfnA7RD01Pvi1I42PUeo6nS2ejuf5kqS0AzelwZ1EFQ2DYHtWXjIafsW6/L2dW5gXg==
X-Received: by 2002:adf:b643:: with SMTP id i3mr11745951wre.284.1561232328886;
        Sat, 22 Jun 2019 12:38:48 -0700 (PDT)
Received: from localhost.localdomain (88-147-39-13.dyn.eolo.it. [88.147.39.13])
        by smtp.gmail.com with ESMTPSA id h90sm7506441wrh.15.2019.06.22.12.38.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 12:38:48 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 0/1] block, bfq: fix mistake causing violation of service guarantees
Date:   Sat, 22 Jun 2019 21:38:02 +0200
Message-Id: <20190622193803.33044-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,
any chance this trivial, but rather critical fix makes it into 5.2?

Thanks,
Paolo

Paolo Valente (1):
  block, bfq: fix operator in BFQQ_TOTALLY_SEEKY

 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.20.1
