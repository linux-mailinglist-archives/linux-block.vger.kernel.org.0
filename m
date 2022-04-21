Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3012550A785
	for <lists+linux-block@lfdr.de>; Thu, 21 Apr 2022 19:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391000AbiDUR7j (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 21 Apr 2022 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiDUR7i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 13:59:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E449C46165
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 10:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f7qsl0wuzlN+We+YckfR1ZlSyXconLmQzfiazp6GcNQ=; b=H7dDgrOezWvMiFG1vqjjOVPbUi
        3cWfanle3D1y5ExnRcQ8OOI1w1DHQ7FN+p/a1bwSCCcfImZC+GPiBCr99AME4LLCA0UrRM8Ak5IGF
        hbDmzF4uS3jmxWgsSKGx3nvKVTb5scPWuvbqZqTPx2IJ+Qi5au2kY7qNKyXvTKi8GvC12QEzzSOeF
        4Q0HpdMTVptQbsvLlvZO2JxwH2vXS59Og3ishxOoZ7syMJMgPrd+ajRMwqfNbhoARHaB98bVkek8m
        yo66IbXa31zSVpXukYeUw8BYKLJQ1Hw4NpH9j0VcaYG51qz+rf6NojnOijhwgqeze+bJQ8h8QFs6g
        kRFHJCRQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhb2p-00EWPR-Du; Thu, 21 Apr 2022 17:56:43 +0000
Date:   Thu, 21 Apr 2022 10:56:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: can't run nvme-mp blktests
Message-ID: <YmGa2yzufsI1TLiC@bombadil.infradead.org>
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
 <YlZXOC4VgmDrUGIP@infradead.org>
 <YlcKqu3roZQSxZe8@bombadil.infradead.org>
 <YlcLOM49JsdlBqTW@infradead.org>
 <af030072-d932-5e38-64d6-bfd28152862b@acm.org>
 <YlkAlHe6LloUAzzN@infradead.org>
 <587c14e7-2b7e-74ac-377b-6faafcb829e4@nvidia.com>
 <YlmyiXBHyqtDQ+g9@bombadil.infradead.org>
 <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d49f3d3-b0ca-8bc9-1be3-c68d0571c98b@acm.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 15, 2022 at 11:09:33AM -0700, Bart Van Assche wrote:
> On 4/15/22 10:59, Luis Chamberlain wrote:
> > That's about 3 block folks not being sure whether or not it helps. And
> > the complexities of it, to test it, requiring a different kernel seems
> > just stupid. So I'm going to drop the tests from kdevops and not bother
> > with them.
> 
> How about modifying the nvmeof-mp tests such that these use NVMe
> multipathing instead of the dm-multipath driver?

Patches welcomed, I'm just going to ignore nvme-mp for now.

  Luis
