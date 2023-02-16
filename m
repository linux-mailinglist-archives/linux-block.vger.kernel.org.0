Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B89698C87
	for <lists+linux-block@lfdr.de>; Thu, 16 Feb 2023 07:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBPGF3 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 16 Feb 2023 01:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBPGF2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 01:05:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C928736FCD
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 22:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ibOnLORQjcn1FdWDW86sZIua0lYA+LAhsi21f/xAJuY=; b=QCRbV34RRTz08qGsJT28wC02Mh
        6+HCdvpIjMuA7vOfsNt3bpuQhIqYJPGNi2In4SA5kimlG3+0ol+qgXvB5qAPW0duy4VvVpd0XK8k3
        WVl0Iv9PZr0/7enPAnGNDNsXTjW3sD8SbPJh8CYQ+54il9sD+81+Csc4S8w5cPflQDqiS7+5PjLxK
        IUgC/65/GsR/ixaQG3j5W9jh0XhEHEuIyE7DoG6rQj8P2FJyTcWGi4kOWWG/MxK/yTSfSgTSYvx/c
        ixiSnmncroMPP/v2fUZkiQcEjZte4kPLpNu5+PMQEWJ+y9bEkwKuZGvJoJHMVsZam0ZQrzgon1oZK
        ktiMnBnQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSXOY-008e4D-8F; Thu, 16 Feb 2023 06:05:26 +0000
Date:   Wed, 15 Feb 2023 22:05:26 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Saurav Kashyap <skashyap@marvell.com>
Subject: Re: [PATCH] block: bio-integrity: Copy flags when
 bio_integrity_payload is cloned
Message-ID: <Y+3Hphbq5NIyXDwf@infradead.org>
References: <20230215171801.21062-1-martin.petersen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215171801.21062-1-martin.petersen@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 15, 2023 at 12:18:01PM -0500, Martin K. Petersen wrote:
> Make sure to copy the flags when a bio_integrity_payload is cloned.
> Otherwise per-I/O properties such as IP checksum flag will not be
> passed down to the HBA driver. Since the integrity buffer is owned by
> the original bio, the BIP_BLOCK_INTEGRITY flag needs to be masked off
> to avoid a double free in the completion path.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
