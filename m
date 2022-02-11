Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C71F4B1EDE
	for <lists+linux-block@lfdr.de>; Fri, 11 Feb 2022 07:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346492AbiBKG4g (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 11 Feb 2022 01:56:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243646AbiBKG4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 01:56:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0961A3
        for <linux-block@vger.kernel.org>; Thu, 10 Feb 2022 22:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SY7qUwpiT3hqqbWGks1R/DDu8ltbPJie+1BmrM9vPgI=; b=jG5Cgx8HQSPPG0etm5raYslj8v
        4+JSYpWADZNXAwAn6tN0ytySxMoED0wrewzljgNJo3RTUShxlCQ/i6TC9Xh7vfsssk/YT/86AkHVD
        lvldm5Zh0yXHru7UjYYQsGOg4ysOyTX7uoIJrjworAmIKrWw4CRPF9hqbvX7dofPl5ZfklU00iBG3
        A0nG0bHg+OhAnJshxkJTU2NNchbLUuas2gpwSBnJCEGbWD7VlK0/tH/DSuTyqdpAOcnoebKPH13ej
        2kse5PklC0t1iYP/9W1nd6DCKwkP6vGBbQo8mNCTW9xz+FirAaDLgKNrRiXNvtM9hffp1fuKqAkBm
        P+eo/k6w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nIPr7-0061wM-L6; Fri, 11 Feb 2022 06:56:33 +0000
Date:   Thu, 10 Feb 2022 22:56:33 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/14] dm: record old_sector in dm_target_io before
 calling map function
Message-ID: <YgYIoaU1p6aRjSTp@infradead.org>
References: <20220210223832.99412-1-snitzer@redhat.com>
 <20220210223832.99412-9-snitzer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210223832.99412-9-snitzer@redhat.com>
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

On Thu, Feb 10, 2022 at 05:38:26PM -0500, Mike Snitzer wrote:
> Prep for being able to defer trace_block_bio_remap() until when the
> bio is remapped and submitted by the DM target.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
