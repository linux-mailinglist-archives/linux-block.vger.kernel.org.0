Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D14DA3476F2
	for <lists+linux-block@lfdr.de>; Wed, 24 Mar 2021 12:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbhCXLTH (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Wed, 24 Mar 2021 07:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbhCXLTA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 07:19:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A8DC061763;
        Wed, 24 Mar 2021 04:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+nZ+LKCV6XV/kweltGWw/hLt2oJ/PRBM7wOTuEH0/Ho=; b=EzCaUQ/cnBX9PgdNTP4ImKya1j
        bjHAmfBY9k2pkhnPnZ0ZKiyB1yuMd7msHCRO5BfaBIXaO7YLqXzGnTM51t46nUz5nHhdzebcpTQ6g
        Y5yZ4xCBgKEuA/+g2Bea2+haofpziE8t1FLywufSBd+NVJDMmyTTYL19aCXi19howw6Y3XuhT18TE
        2lTJW35fC035hKojHN4jRKgDrSy46weNwIvY67MgkylSzUU7c9Csb+Z9yOdkYTpN8AxiJjjmEi73V
        Vf9LJDTCpYRdMdXog1/6nMedB/V5KBt9Bnom8OpVSyfjywX4FAPT5Xg0OdFDWoRk1OGErU9JBZYIS
        YALMEEPA==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lP1WV-00BHLB-SN; Wed, 24 Mar 2021 11:18:10 +0000
Date:   Wed, 24 Mar 2021 11:18:03 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel.tide@veeam.com
Subject: Re: [PATCH 1/1] block: fix potential infinite loop in the negative
 branch in __submit_bio_noacct_mq()
Message-ID: <20210324111803.GA2687609@infradead.org>
References: <1616500116-3411-1-git-send-email-sergei.shtepa@veeam.com>
 <1616500116-3411-2-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616500116-3411-2-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 23, 2021 at 02:48:36PM +0300, Sergei Shtepa wrote:
> When the blk_crypto_bio_prep() function returns false, the processing
> of the bio request must end. Repeated access to blk_crypto_bio_prep()
> for this same bio may lead to access to already released data, since in
> this case the bio_endio() function was already called for bio.
> 
> The changes allow to leave the processing of the failed bio and
> go to the next one from the bio_list.
> 
> The error can only occur when using inline encryption on
> request-based blk-mq devices and something went wrong in the
> __blk_crypto_bio_prep().

A continue in a do { } while statement evaluates the while condition,
so your patch is a no-op.
