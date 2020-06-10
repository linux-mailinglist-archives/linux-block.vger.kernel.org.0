Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1326F1F4D1D
	for <lists+linux-block@lfdr.de>; Wed, 10 Jun 2020 07:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgFJFne (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 10 Jun 2020 01:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbgFJFne (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Jun 2020 01:43:34 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C7AC05BD1E;
        Tue,  9 Jun 2020 22:43:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49hbWQ50Pcz9sRR;
        Wed, 10 Jun 2020 15:43:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1591767812;
        bh=pcbWSPwKHYKUiqwhEF2FHnUMBRR9mr+AM4yZy/n/Q8I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F8IQUAA3kWCkFCWuHeYkNqUREzy+4KqCzh7klNtixSzs921xmG/GxnersS77Mi9/U
         sHdjk4Z7XhsgEB7dPXauvZKo+NcLEu3WHhqsl5ZY/4CW0u7jVAW32uOTtZ6YWGSylg
         pFPYCAzg0F7MsWCrUBF47Sc/Oh+8/13K+3iK3IybEYtDsD2Q0N/EMOLzKlY+fP3L2E
         K7QaVdu8KaiWPWhrmPr+YwUV2ymA7pLeI0l0Rz+FSumECm/O5gFxfyxLLFdUm7oaaP
         Skn4eyNynDdzqfMo/nful4oZI19JZlMkg8XiWqA4xqgbRrEpMvSZ85VlksnkXwNL5M
         EeRvhl8RR3JNQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     brking@us.ibm.com, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org
Subject: Re: ipr crashes due to NULL dma_need_drain since cc97923a5bcc ("block: move dma drain handling to scsi")
In-Reply-To: <20200609154230.GA18426@lst.de>
References: <87zh9cftj0.fsf@mpe.ellerman.id.au> <20200609154230.GA18426@lst.de>
Date:   Wed, 10 Jun 2020 15:43:58 +1000
Message-ID: <87tuzjfpb5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:
> Can you try this patch?
>
> ---
> From 1c9913360a0494375c5655b133899cb4323bceb4 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Tue, 9 Jun 2020 14:07:31 +0200
> Subject: scsi: wire up ata_scsi_dma_need_drain for SAS HBA drivers
>
> We need ata_scsi_dma_need_drain for all drivers wired up to drive ATAPI
> devices through libata.  That also includes the SAS HBA drivers in
> addition to native libata HBA drivers.
>
> Fixes: cc97923a5bcc ("block: move dma drain handling to scsi")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Yep that works for me here with ipr.

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
