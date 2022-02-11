Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FA04B1EDA
	for <lists+linux-block@lfdr.de>; Fri, 11 Feb 2022 07:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbiBKGxt (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Feb 2022 01:53:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiBKGxq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:53:46 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C5290
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yBIKoqi6944pouOow5a85PWCW+IDD0mZjzRBq4eHhno=; b=yf/Ps6WfpSYgbcs9r1KB+IbSzs
        O0PJjuVtP7RfK8lpMdeMqStQJTrTTUdLG0/8swK43qY2AHG3Dur5OkzPPezo/9x4gmsfvMzS/U0xt
        SfZfVuSNkxhvL93HGceLGQFPW0BrL3HfSWiaDkVxyAsnpr34Dz0VV7xufYVmZEhalvGsmvTR9Rgn4
        SPV7aVHR55ExR6YMKhjD5fAPFbEtu2+0d1RI+zG5OjmBa1iKPC9dqMsiJJ1SX+oJolJ6Xwb6pelsv
        OTjasREmlnCkeJqIzUEH5IwOqcdvXR6byqOSZSWs/UFjKzgLpXfEjQWzFW7khzF4pUOhw5ujEXxKV
        6ihA6hlQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPoQ-0061Vl-7v; Fri, 11 Feb 2022 06:53:46 +0000
Date:   Thu, 10 Feb 2022 22:53:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/14] dm: remove unused mapped_device argument from
 free_tio
Message-ID: <YgYH+vPaQG/aMr4f@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-7-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-7-snitzer@redhat.com>
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

On Thu, Feb 10, 2022 at 05:38:24PM -0500, Mike Snitzer wrote:
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
