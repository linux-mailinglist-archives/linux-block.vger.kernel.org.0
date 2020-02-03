Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E33511511FB
	for <lists+linux-block@lfdr.de>; Mon,  3 Feb 2020 22:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgBCVk4 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Mon, 3 Feb 2020 16:40:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43937 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCVk4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 16:40:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id u131so8500444pgc.10
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 13:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sAZj60TI37inPLUNTEQqnU5KaEuQfNMyVmeypIO4YWY=;
        b=Tjtz28Dtz40rVpdiBBcz/KH9UNOA+ItkQDJhT1UB0bql7oFbo6gcqQyaI86qDHnHkO
         tWlZ1kyNz99ss6Qqm3jQmlMebrCXKNNKdGG/hbT7e7Q0QSMXJlRzKlGJgVBhEPEbSXm3
         nisisaJblkKOJhta6gJezGiNo6BSBc2oQi3v+sZf4B4v6llK6jSeJJSk9PTYBEKi1mZ0
         yticOxcUtRWESK/BNlEWIx5vvwxOdgxw/wHiYoePO4+DwdwijKljk/pMLAxpXMm6MrI9
         4g/dF8crvICbOqsIe4ugU7iIdCDCmsLgTRjwbY0xX0MsumD6I8QPDUqCcxuzdiyFKH0r
         2qmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sAZj60TI37inPLUNTEQqnU5KaEuQfNMyVmeypIO4YWY=;
        b=KDH3jDPlmpmib0ZwkezZz97kyo7D5HFrHVc8D5mrzRyYB89IaDMJbRCT1gK6Otz1bP
         xwYMpCsOpiXg4A1h8bqpTSiXL2/8ZSZXfoovgHrjX6/KRSglfxBd4EvkAWMuscTs2ZWE
         tLsU4grurhLP/tyAFguh4fmvnPx5h3XP1ggfG9lLBqSIq4LckC/oQTAuai/SDqewhFlK
         faFNrdnBTXYjw3j5ZG9loXQnquXQ7nOuCi9GRShcWPsImACqnOUqWWaIr4+x3DGLPPka
         UKNDYD6RniWDyeEMtouLg1YbfOehezDAUR3Nz78pWeor9Ne2GPA5z2OkMv1qOiIe5mvE
         upcQ==
X-Gm-Message-State: APjAAAWDxOnoOl/1FjvRWRBcOcuaVLrJDWY+eWgs6scYui37KnyKV233
        ND8ws6+ZZExELOTEphXmxllCBw==
X-Google-Smtp-Source: APXvYqysJRav8ZqhQqAziJjjkWKnz/2XU2U7Lr0pEnHptc04f93v4MwYCRXW1f3znmNUisdTSrYsrA==
X-Received: by 2002:a63:6c09:: with SMTP id h9mr26641803pgc.34.1580766055545;
        Mon, 03 Feb 2020 13:40:55 -0800 (PST)
Received: from vader ([2620:10d:c090:200::d68d])
        by smtp.gmail.com with ESMTPSA id y24sm12861119pge.72.2020.02.03.13.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 13:40:54 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:40:52 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        "Elliott, Robert" <elliott@hpe.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH blktests v3 0/2] nmve/018 fixes
Message-ID: <20200203214052.GA1025074@vader>
References: <20200203164049.140280-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203164049.140280-1-dwagner@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Feb 03, 2020 at 05:40:47PM +0100, Daniel Wagner wrote:
> changes from v2:
>   - fixed another typo (argh!)
>   - added reviewed-by tag from Keith
> 
> changes from v1:
>   - added reviewed-by tag from Logan
>   - patch #2 fixed typo in commit message
>   - patch #2 reworded error message as suggested by Robert
> 
> changes from v0:
>   - added "nmve/018: Reword misleading error message"
> 
> Daniel Wagner (2):
>   nvme/018: Ignore message generated by nvme read
>   nvme/018: Reword misleading error message
> 
>  tests/nvme/018 | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks, applied and pushed.
