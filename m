Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E36984B1ED6
	for <lists+linux-block@lfdr.de>; Fri, 11 Feb 2022 07:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbiBKGw7 (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Feb 2022 01:52:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBKGw7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:52:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A026191
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zyc6RD5MT7FvVbVdoGQvM86WFTD5K2Z4CPztcgjYDck=; b=zsZqyhkJsHbDS4UV1I1sLyKC19
        ORcwEJBREATj87d0593Ch2GhbVb4wfO6hW0p587QEwT1f7C9VqQ19RmVtFA2le1EQgMYZJa+2SKc4
        E9ykHhnBrslnpNl2FykJhQYgD1N6lwIOLzuDa/GFU7ded4RnKJDPytLMftHuUiTAxCE42i4jlV10R
        jKucJ7q/nOzl9rlQUHYDCPtHeabtznkUEvXemgsY53UOBn3QiKc+fFXpUfI2c425nsxgP1jlJk1YC
        kqFbqjh+hFdcR/I64c5NSX2lgSNmJqgVp6UU1f447+/ppx46J1MchRj+5pOF9MvaKx6cYDTsaSd/Y
        I2X/SRcQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPnc-0061Ow-V1; Fri, 11 Feb 2022 06:52:56 +0000
Date:   Thu, 10 Feb 2022 22:52:56 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/14] dm: reduce code duplication in __map_bio
Message-ID: <YgYHyGp2IP9xcttT@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-5-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-5-snitzer@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 10, 2022 at 05:38:22PM -0500, Mike Snitzer wrote:
> Error path code (for handling DM_MAPIO_REQUEUE and DM_MAPIO_KILL) is
> effectively identical.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
