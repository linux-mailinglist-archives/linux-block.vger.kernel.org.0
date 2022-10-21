Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A85C607E10
	for <lists+linux-block@lfdr.de>; Fri, 21 Oct 2022 20:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJUSGe (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Fri, 21 Oct 2022 14:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJUSGd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Oct 2022 14:06:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A81123453
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 11:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCF87B82CC2
        for <linux-block@vger.kernel.org>; Fri, 21 Oct 2022 18:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9D81C433D6;
        Fri, 21 Oct 2022 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666375590;
        bh=mTejb0AwfehQYdudLc2ElFAEubnJK8SPY4tBcgRtmmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fqxxihuIAzrZOl9DgmRlGtgdG+hYQ6X4WvVzfgLCEzWUi3um+0rS4AmHPAj/lFBe4
         4GJNYaamOUW5G85tjRj2qLuuuK6AoRksi7wI5Yk7Fl/xB03DVWZ3QhOcN4Z2ovEVdP
         C1dkUrgzHWl1q1ZONR+ZQZX6jC0fOJJogwkLKiETjGBNg/GG3I+cqSS8eMa7KJl3ox
         b0yoGvXhK8Qg5FdkCq3RmzaWo8DEu+vN6Pm13SqSNPQUxTJsFPtyCD0rdqsCpZOnn+
         EHjATHTDUebRoct2ijhkl+1jG5meAB/LiFhA+OF4+KZtTTynSSXXqDjGHVyTwxesnj
         hhk05kSclCLRQ==
Date:   Fri, 21 Oct 2022 12:06:26 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        Chao Leng <lengchao@huawei.com>,
        Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: per-tagset SRCU struct and quiesce
Message-ID: <Y1Lfoj5Hgz8FwJzu@kbusch-mbp.dhcp.thefacebook.com>
References: <20221020105608.1581940-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020105608.1581940-1-hch@lst.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good; for the series:

Reviewed-by: Keith Busch <kbusch@kernel.org>
