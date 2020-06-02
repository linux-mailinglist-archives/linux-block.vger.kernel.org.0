Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507CC1EBDE2
	for <lists+linux-block@lfdr.de>; Tue,  2 Jun 2020 16:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbgFBORj (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 2 Jun 2020 10:17:39 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:52695 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgFBORj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 10:17:39 -0400
Received: by mail-pj1-f50.google.com with SMTP id k2so1431410pjs.2
        for <linux-block@vger.kernel.org>; Tue, 02 Jun 2020 07:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QzKU27OAkrjSQuPEhW+8khPDASbGPxn01itV3ETlpOQ=;
        b=g8TsOgINXLajEROfdwdIcW5kaTWr++I1xm2B5YFgib1DTuGjmfsfgVXLgJf5QzkdaB
         MX1XnAiMrgN9hfVqFXuNhkWvD04TgpPZEFWho9z0p4vlj8U/FqdpkeXT+joKykiZUrrM
         1JluwV9zW8YfAeBUTfA6RdSkQ/n7SWXD94oWda+gb65wTj8VcBjO8OATXgfWRPhVRlEq
         VGYF7wHO19IJ0+H0lHbFm1POwEV8Nrlqr+HEXqeVxBaXL1svGYcXUdqtyjX9Twq4l9gm
         5Qc2pvkYX1Qv08d9HlaBdUB85kJ1iw43o7YivrT81NSjACwilh1YU05Ow9KKH5tjSK0d
         pruQ==
X-Gm-Message-State: AOAM532A2gM5lo2EFiEbIUnoAQysO055j09vXjQx+EU0vxqXYlheVEVJ
        auRbBjWIYSlmbCTk048tqZJR/OnR7To=
X-Google-Smtp-Source: ABdhPJw23rBZJN2sXej3OM2ebvLL0q6dzmkXByz4sJnc06YvGAHGNELTcqhST6bDfuYYrUwUT8HUrw==
X-Received: by 2002:a17:90a:8089:: with SMTP id c9mr6086419pjn.126.1591107458048;
        Tue, 02 Jun 2020 07:17:38 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id g21sm2290414pjl.3.2020.06.02.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 07:17:35 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C402340256; Tue,  2 Jun 2020 14:17:34 +0000 (UTC)
Date:   Tue, 2 Jun 2020 14:17:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, bvanassche@acm.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] blktrace: Avoid sparse warnings when assigning
 q->blk_trace
Message-ID: <20200602141734.GL11244@42.do-not-panic.com>
References: <20200602071205.22057-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602071205.22057-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 02, 2020 at 09:12:05AM +0200, Jan Kara wrote:
> Here is version of my patch rebased on top of Luis' blktrace fixes. Luis, if
> the patch looks fine, can you perhaps include it in your series since it seems
> you'll do another revision of your series due to discussion over patch 5/7?
> Thanks!

Sure thing, will throw in the pile.

  Luis
