Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11C2557D60
	for <lists+linux-block@lfdr.de>; Thu, 23 Jun 2022 15:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiFWN5q (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 23 Jun 2022 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiFWN5q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 09:57:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3131B381B0
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qo8jsw0100boFA4s9S81a4xovslpCh+9qUBJ9MQZNg=; b=SUn/puWgDDid28/63POKl9crVr
        Fy0lRzDH+xRC0IiQUTDfSRA+yrjbGPxubm0TkBD/wQRm4TGlFFaoV3UZLYE6etyZtOOolJ33R8GWg
        3iRtxmOlWshe6x9EKBvofDOnVn2QbNnXX/lKI+6uqkgf03XzHkeJNfMbumkV9rpLIuzT14TYA3BoO
        P+4FstAFNjHBBwVXKiPW7FnQIZdZgBh0xe3QKr3O+TxdzqIGizAWx1KtpMtYs22GQd2oLVAUv2CWE
        ic6F8C50GnJAMy98DB2rxsMVcPRvFCeV3fiXVS1y3l+BGzS4HVKfG7TfIhulzf4437KT3NEII8sCn
        GLcabzWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o4NL7-00FRRl-57; Thu, 23 Jun 2022 13:57:45 +0000
Date:   Thu, 23 Jun 2022 06:57:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 2/9] block: Return effective IO priority from
 get_current_ioprio()
Message-ID: <YrRxWVtDyRUajNHN@infradead.org>
References: <20220623074450.30550-1-jack@suse.cz>
 <20220623074840.5960-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623074840.5960-2-jack@suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 23, 2022 at 09:48:27AM +0200, Jan Kara wrote:
> get_current_ioprio() is used to initialize IO priority of various
> requests. As such it should be returning the effective IO priority of
> the task (i.e., reflecting the fact that unset IO priority should get
> set based on task's CPU priority) so that the conversion is concentrated
> in one place.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
