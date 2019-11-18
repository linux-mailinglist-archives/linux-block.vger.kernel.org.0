Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6199D10084B
	for <lists+linux-block@lfdr.de>; Mon, 18 Nov 2019 16:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfKRPdO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 18 Nov 2019 10:33:14 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36042 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKRPdN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Nov 2019 10:33:13 -0500
Received: by mail-il1-f196.google.com with SMTP id s75so16380966ilc.3
        for <linux-block@vger.kernel.org>; Mon, 18 Nov 2019 07:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YS184bGN6J9aePOBe16ozqbDzE/B0ihMCWCOanLvA5g=;
        b=vLpgu5v+D2olah9Wi43FZ6HK8MhA2Y5rf8HIDP/s70aP9Efbrd3heTA6s4ZlNIKs0n
         ISkSRgR1l9H9wH/43ehcjXj+w70RoyMQAXC0w2YEgZm5mOifEXGN/tzKyx82wGIuCyZ3
         L0BoWn/J9hW+h3sL+pKDbyk9J0HjIFBfir1gt6y/LWvik3ojjsSo9NysNFfNB0SL2OAu
         mlma09eTHtOtokmu0DyHw6mHxQnlZWHr7UxcJOmXH0VK4KTtSur4B5+Y2D5WjXxlUISJ
         3SFUNXvZNnyXedpAm5by+A9KzSpew63ijEEdTBWbNN0fMvWU3BUTjD3MvIR5aC9IoE5F
         Rr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YS184bGN6J9aePOBe16ozqbDzE/B0ihMCWCOanLvA5g=;
        b=XxgMGtraEwNGqUbhX19SS1kMKsxyZYL9nQ8oeQgx92ZrHCfe093YO7tthZO/B9Mazq
         2tsLiaBewkJbF/5xOAsiYLvp16c3Ns7qEVtz+7v2OB4qPo/NxhhvtdaCUZ2cuM61u3Y7
         kP0IbhIZ0xdY066wNZ4oeUwslYgkJYuHSVBr9OmRwo/A02HBHu4HpaPwyXQwS2HwA5KC
         LYoyR8MgNtIa6tVVAcDyLn50VHgEdy9kxhy8LIzCGF9sGxUR9kh1p3v4KxaxepDlXva/
         aZr2qu5XXDGEXK8JMCPy6NtqdwKwrFYid95Imp0UrAgGf/4uFhNyAOkELcXL3clDo/Oa
         fXdQ==
X-Gm-Message-State: APjAAAWMI08H8agKF1qEKTiij4thn7uEt59+7Ge+GrbYQb32L0JkLOuN
        /ujRTYEZKsfAYqjhxXnroOQv1w==
X-Google-Smtp-Source: APXvYqzwsBX5JB5z9XzVfjupL4dDEpkaqvxBhu+HScemh7bwuROVhXdNmpSWX/fjlI/hINiwDg/PcA==
X-Received: by 2002:a05:6e02:d92:: with SMTP id i18mr15984126ilj.20.1574091191085;
        Mon, 18 Nov 2019 07:33:11 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z69sm4547097ilc.30.2019.11.18.07.33.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Nov 2019 07:33:10 -0800 (PST)
Subject: Re: [PATCH -next] scsi: sd_zbc: Remove set but not used variable
 'buflen'
To:     YueHaibing <yuehaibing@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
References: <20191115131829.162946-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <321d25d4-2216-dae2-268b-ca225c5e5caa@kernel.dk>
Date:   Mon, 18 Nov 2019 08:33:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191115131829.162946-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/15/19 6:18 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/scsi/sd_zbc.c: In function 'sd_zbc_check_zones':
> drivers/scsi/sd_zbc.c:341:9: warning:
>   variable 'buflen' set but not used [-Wunused-but-set-variable]
> 
> It is not used since commit d9dd73087a8b ("block: Enhance
> blk_revalidate_disk_zones()")

Applied, thanks.

-- 
Jens Axboe

