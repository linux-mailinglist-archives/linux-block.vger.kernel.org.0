Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A1C60DA01
	for <lists+linux-block@lfdr.de>; Wed, 26 Oct 2022 05:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiJZDoO (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Oct 2022 23:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbiJZDoL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 23:44:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF1967C88
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 20:44:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2AAEB81FDF
        for <linux-block@vger.kernel.org>; Wed, 26 Oct 2022 03:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01541C433D7;
        Wed, 26 Oct 2022 03:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666755847;
        bh=3NURWuh4eM8vd9QSXMbLoCUo7O4RIWU9sDbYvYDkMbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4fCmJQlJqRDWqmWgt4nJ10UCdugvfOFUUefkqAUNyV9BA0lE9Yv5tI9KhmQQTFql
         DLs0/IgbjMdtoijlne4FWP3flnhv5GKGphGLihWRVQKsNq/cRPYV+Tlz8wcKes1M7t
         /sSNS4SH7tqyOUpNqptL3YxUeGhv/CyDW+OBeV+9fIq9KyhW1Th0zExxWScgQzvGla
         FWYBnhkk5lE2DrlyTJgZCl5+gdVVRDYKSkqXuVD2bJE4A53KAjLKhrsae1RCmZIuSv
         oCuj4lP6Aiq49muJC5wrDheHmhc4Slt2mdOVJQz7NxZhIF0EUD2mu3R2mXvwOGcMBJ
         kJUbb1HP7Wdlg==
Date:   Tue, 25 Oct 2022 21:44:04 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        David Jeffery <djeffery@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V2 1/1] blk-mq: avoid double ->queue_rq() because of
 early timeout
Message-ID: <Y1itBDjV4I+mXkKp@kbusch-mbp.dhcp.thefacebook.com>
References: <20221026015521.347973-1-ming.lei@redhat.com>
 <Y1ilaQV3hz6kudH3@kbusch-mbp.dhcp.thefacebook.com>
 <Y1iprFhtHLSESDdJ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1iprFhtHLSESDdJ@T590>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 26, 2022 at 11:29:48AM +0800, Ming Lei wrote:
> Both two are basically same, with two callbacks, just .check_only is saved,
> nothing else, meantime with one extra similar callback added.

They don't seem to share much at all. The original callback was 4 lines
of code, and the special case adds 5 new lines that returns before half
of the function's pre-existing code.
