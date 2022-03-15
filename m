Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A974D95F0
	for <lists+linux-block@lfdr.de>; Tue, 15 Mar 2022 09:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbiCOINr (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 15 Mar 2022 04:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238106AbiCOINq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 04:13:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C614E4AE11
        for <linux-block@vger.kernel.org>; Tue, 15 Mar 2022 01:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=67WaoG1t7x1i9Br0EX6h+YK8WFf+pu6otiU2K0O6F44=; b=N1nDqi+8qTbXsxK1JvXI9unXlr
        36B8/1d7PR5rwhurlYqlqP/ryinpk37Jl9NP8t6ofPNjcL67ZJJK/PcL+BKu2R//Zr+Xm+Wzvdpic
        GP0fbAhzbAcqBYkNnCIxYCPYFqKmUXmdM8RD5amBVpwXMmrb9awHdnONMboIO5GoxLkek++qcj+7i
        vKHzR2HHHEalH/yTHi/JVVt+5l4uYLFgDAIlKgI565PQL0Bbmo4NW+N+QHjGnMqbMsf2K5wxMFQSU
        Te2FZf5m921MToaQ2BK45ia8QywxAk2al/Q7cMR5S5iS4CumATPY8ytoRV77i4kggsWykEYXK61kS
        Mftr0bOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nU2I6-008Egg-SO; Tue, 15 Mar 2022 08:12:26 +0000
Date:   Tue, 15 Mar 2022 01:12:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <michael.christie@oracle.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Message-ID: <YjBKaoBYtofJXrgw@infradead.org>
References: <87tucsf0sr.fsf@collabora.com>
 <986caf55-65d1-0755-383b-73834ec04967@suse.de>
 <b6bb4435-d83c-b129-c761-00a74e7e0739@grimberg.me>
 <87bkyyg4jc.fsf@collabora.com>
 <e0a6ca51-8202-0b61-dd50-349e6f27761b@grimberg.me>
 <45caea9d-53d0-6f06-bb98-9174a08972d4@oracle.com>
 <6d831f69-06f4-fafe-ce17-13596e6f3f6d@grimberg.me>
 <0b85385b-e8cf-2ab3-ce22-c63d4346cc16@acm.org>
 <c618c809-4ec0-69f9-0cab-87149ad6b45a@suse.de>
 <d2950977-9930-1e80-a46d-8311935e8da4@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2950977-9930-1e80-a46d-8311935e8da4@grimberg.me>
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

FYI, I have absolutely no interest in supporting any userspace hooks
in nvmet.  If you want a userspace nvme implementation please use SPDK.
