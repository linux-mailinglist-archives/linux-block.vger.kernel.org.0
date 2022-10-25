Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E6E60D4D3
	for <lists+linux-block@lfdr.de>; Tue, 25 Oct 2022 21:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiJYTkd (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Tue, 25 Oct 2022 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiJYTkd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Oct 2022 15:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CEA836D8
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 12:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D683261B08
        for <linux-block@vger.kernel.org>; Tue, 25 Oct 2022 19:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3290C433C1;
        Tue, 25 Oct 2022 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666726831;
        bh=u74yg/M4Fxkx9BQwfM3eTdqX2f0fV4spwaVbAhO6bhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7byxNSblotdqWhT2Ee9jmQZGMn0XgONmPk6DqlK1mYck3q0zEDcW/XKTWnkDmKG0
         EOeJrc9SDAV/RJfCEBdzBJFZkwETFlbc4pNRVZ5ZSrWzgzO3wSgu49jK5fM5BfRvG2
         pCihOY/hVHxGmSBwJvUC2tkHZCG3XX/vmIbUSyXa5tblvDJu9TDWeSsrLfzjMg9ZUD
         2CVTut4ermZvbXZfDWWnQ2gu5rh+GRcL6BFb8d5lYLkW2pO1O9YcD0Tbpyo7g8Htv2
         G3HZHyKV23T03aaWiO/9Z/SDwDoUnmYhIgei6VI/WCNvxM6HOCpSjoqx7mmPe96QEn
         qsAbsDLDS3bwQ==
Date:   Tue, 25 Oct 2022 13:40:28 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/3] Block layer cleanup patches
Message-ID: <Y1g7rO5uGjWg7IvH@kbusch-mbp.dhcp.thefacebook.com>
References: <20221025191755.1711437-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025191755.1711437-1-bvanassche@acm.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This series looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>
