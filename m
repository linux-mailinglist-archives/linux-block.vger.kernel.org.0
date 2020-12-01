Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2173A2CA4E7
	for <lists+linux-block@lfdr.de>; Tue,  1 Dec 2020 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388300AbgLAOFH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 1 Dec 2020 09:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbgLAOFG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Dec 2020 09:05:06 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C6FC0613D6
        for <linux-block@vger.kernel.org>; Tue,  1 Dec 2020 06:04:26 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id s63so1246576pgc.8
        for <linux-block@vger.kernel.org>; Tue, 01 Dec 2020 06:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Wp+3VtFlwupaso5xzNNSSHMU/XlvxPbQQMG9fDuF0wo=;
        b=Cr8nYcM722dhBnC+B1T7MVFBU40CBtgxWGdnZ99e1J2Aj0Rjn7Xv/8IpeqN4BQ1RAo
         9PvgugcypnlRIjLCCHnNDQq+F3yv/5KPUdWnb/IH6mvCK+BrUMcF0sZeubuVfTCzUqaE
         dZ+jjfpm85rYsslU4XL2ntz3ahQu0kGLtG5zhQDjy7bTqfbUSfP5jmUj9k8s9Xogjh7z
         6EVozktjYnoBhhrkr0V0PfrS7Q1vbvgQ/6kK7l3zq9fsR8ZaVUnR/LR4v9nnbPV/tnI6
         wU1Npko8Y42FO+Ubk9im0ee44iYDIWCvvHyS9LAQ/kQvAV7itxQiRM4psGyDtZqHXzCe
         Q4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Wp+3VtFlwupaso5xzNNSSHMU/XlvxPbQQMG9fDuF0wo=;
        b=jEV/KDCRn7zLO5DQJmQp2aZnUjU4f/o1h/NwgLOREq3wLmm2WqSBoNdc/tIk0TTfUd
         BurR3VcNju7uKj32fZp3ywfvFsdNu48BcHjowzeKRxmloW4ubOWrRm3tYTsiKHJ4fSOg
         h+GMnZ7+DJyjbR/jamZYVHSQsVjoka7qnCI7WDxg4lXPImF/PXUw6oFJDUvg5mZoIeTB
         5jvCY8AhK01usEzVzUicR7ESI9RoOxft/i4dfN+yWe/hu1gvVPSkxAH7064GYzHFXymg
         Yyl2n5+Zjk+4pb9vyHmruHfvHdTcWGdYSjUmYqbCY5Wr0SVd0AhJWWATazpnbxbOjDKI
         YZ4A==
X-Gm-Message-State: AOAM532b4g/gqSW1fdepZ4Q09fgWL/5nnk4szq6fQRIkZ7jsXFd0yj67
        eUHZkTjVt+5qe+ql+NlYImQ=
X-Google-Smtp-Source: ABdhPJw9O1XpQSrqoTsTfkvUvMvp9nmBjI42VUoh2IFNkKkRbPlxaA3MGhhAXQfWIG6bIJYLrYSkYw==
X-Received: by 2002:a63:cb47:: with SMTP id m7mr2310226pgi.395.1606831466356;
        Tue, 01 Dec 2020 06:04:26 -0800 (PST)
Received: from localhost ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id w35sm3103625pjj.57.2020.12.01.06.04.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Dec 2020 06:04:25 -0800 (PST)
Date:   Tue, 1 Dec 2020 23:04:23 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     javier@javigon.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/4] nvme: remove unnecessary return values
Message-ID: <20201201140423.GB5138@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-2-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201125610.17138-2-javier.gonz@samsung.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On 20-12-01 13:56:07, javier@javigon.com wrote:
> From: Javier González <javier.gonz@samsung.com>
> 
> Cleanup unnecessary ret values that are not checked or used in
> nvme_alloc_ns().
> 
> Signed-off-by: Javier González <javier.gonz@samsung.com>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
