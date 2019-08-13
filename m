Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77288B9B1
	for <lists+linux-block@lfdr.de>; Tue, 13 Aug 2019 15:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfHMNLi (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 13 Aug 2019 09:11:38 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37706 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfHMNLi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 09:11:38 -0400
Received: by mail-qt1-f195.google.com with SMTP id y26so106260633qto.4
        for <linux-block@vger.kernel.org>; Tue, 13 Aug 2019 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q0ylxgOv4N7J3MK96yhPh/s3pBR8tJPHjcHGz1jC9Yw=;
        b=TrdfCmvcXZMpGELvJgaa29QMziep9hmZNOR39fbKj6fQxmmqzBAOxez/Nx7hKOK46p
         mDieTioNIdF5/fEQqI7rUvDfHgdnW6gY6W1sPh3GAkTUSQ4xVKNqfk8EL03HOoEMyBbp
         v/4ru8yNZMMx1xRVkw9YZDLge0QReqPYiOoffLjM5sDcE+udqSveRs59WFOQEkfGrBK+
         v5v5kLqlDEWL1agrToz/8bSkZ6PVEn4wO/2fZLx2bMj/wHSHS3ejoDLaAPSsXqKnUvZu
         r6+IBB7bhktaCNL6GhOsviX6cZnxRqP1oMIOsr2g6ezVXYTlt89pGcZiAaF8tEKiZNWI
         yUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q0ylxgOv4N7J3MK96yhPh/s3pBR8tJPHjcHGz1jC9Yw=;
        b=Qibj9RHGmNwDx0CaPRbTIXtnBWvIhEOQv9v+boSPcni5tGWVne0CrfzJCTsinSD19g
         aLQyiAUk2OgShMLfl2y5e9dTYv/E3GBYBZNyshCeFrUJp6RcA5iX0T8Rh2xFWawZ0+bc
         BjiLL5psLaE/pnmROz0/5oZOYEbeewD7z7qG6ce/amb9+Bhli+YsqBCa5oBBR6sV28+h
         Y3T+9wusBVqPKCAzOh31oEJz+T5bJj6ix36m/clOW0jt5OYAP2iGJDrCBip59zkTlr4f
         mtIloT11ZMh0szRfprWHU4Gr/eZeg4BvckilgpeVhEb2wQ3YJyAFOMCxab/bH1jWePuZ
         Xo3A==
X-Gm-Message-State: APjAAAUWlGldJD3EOE8T5A43ZZ3/GVnRAl8C0gvpis24bSYBet8YwQYf
        ULOEe8/H4HBazj/+09oUEaKZ9A==
X-Google-Smtp-Source: APXvYqybicxW89AmGzRkUKRXSGAT+2TtqAx0DTqxnLxPOuVrv+QRkjn9gThLuC8FDBGIiv0nuvMNXA==
X-Received: by 2002:ac8:1410:: with SMTP id k16mr33303711qtj.335.1565701897154;
        Tue, 13 Aug 2019 06:11:37 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 136sm7862831qkg.96.2019.08.13.06.11.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 06:11:36 -0700 (PDT)
Date:   Tue, 13 Aug 2019 09:11:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Mike Christie <mchristi@redhat.com>
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/4] nbd: add missing config put
Message-ID: <20190813131135.lowte3muvdab23q4@MacBook-Pro-91.local>
References: <20190809212610.19412-1-mchristi@redhat.com>
 <20190809212610.19412-4-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809212610.19412-4-mchristi@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 09, 2019 at 04:26:09PM -0500, Mike Christie wrote:
> Fix bug added with the patch:
> 
> commit 8f3ea35929a0806ad1397db99a89ffee0140822a
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Mon Jul 16 12:11:35 2018 -0400
> 
>     nbd: handle unexpected replies better
> 
> where if the timeout handler runs when the completion path is and we fail
> to grab the mutex in the timeout handler we will leave a config reference
> and cannot free the config later.
> 
> Signed-off-by: Mike Christie <mchristi@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
